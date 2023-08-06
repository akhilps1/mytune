import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:mytune/features/home/models/category_model.dart';
import 'package:mytune/general/di/injection.dart';
import 'package:mytune/general/serveices/custom_toast.dart';

import '../../../general/failures/main_failure.dart';
import '../../home/models/product_model.dart';
import '../../home/provider/home_screen_provider.dart';
import '../repository/craft_details_repo.dart';
import '../repository/crew_detail_repo.dart';
import '../repository/product_details_repo.dart';

@injectable
class ProductDetailsProvider with ChangeNotifier {
  final ProductDetailsRepo _detailsRepo = locater<ProductDetailsRepo>();
  final CraftDetailRepo _craftDetailRepo = locater<CraftDetailRepo>();
  final CrewDetailRepo _crewDetailRepo = locater<CrewDetailRepo>();
  final HomeScreenProvider _homeScreenProvider = locater<HomeScreenProvider>();

  bool isLoading = false;
  bool isFirebaseLoading = false;
  bool noMoreData = false;

  List<ProductModel> products = [];

  List<CategoryModel> craft = [];
  List<CategoryModel> crew = [];

  Future<void> getProductsByLimit(
      {required String categoryId, required String productId}) async {
    Either<MainFailure, List<ProductModel>> failureOrSuccess;

    failureOrSuccess =
        await _detailsRepo.getProductsByLimit(categoryId: categoryId);

    failureOrSuccess.fold(
      (failure) {
        CustomToast.errorToast('Nothig to Show');
        noMoreData = true;
        isLoading = false;
        isFirebaseLoading = false;
        notifyListeners();
      },
      (success) {
        products.addAll(
          success.where(
            (e) => e.id != productId,
          ),
        );
        isLoading = true;
        isFirebaseLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> getCraft({required ProductModel product}) async {
    List<CategoryModel> list = _getCraft(product);

    print(list.length);

    if (list.isNotEmpty) {
      for (var category in list) {
        await Future.wait(
          [
            _craftDetailRepo.getCraft(
              categoryId: category.id!,
            ),
          ],
        ).then(
          (value) => value.first.fold(
            (faleure) {
              print(faleure);
            },
            (success) {
              print(success);
              craft.add(success);
              notifyListeners();
            },
          ),
        );
      }
    }
  }

  Future<void> incrementView({required ProductModel product}) async {
    await _detailsRepo.updateViews(id: product.id!).then((successOrFailure) {
      successOrFailure.fold(
        (l) => log(l.toString()),
        (r) {
          log('successOrFailure');
          _homeScreenProvider.updateView(product: product);
        },
      );
    });
  }

  Future<void> getCrew({required ProductModel product}) async {
    final list = _getCrew(product);

    // print(crew);

    if (list.isNotEmpty) {
      for (var category in list) {
        await Future.wait(
          [
            _crewDetailRepo.getCrew(
              categoryId: category.id ?? '',
            ),
          ],
        ).then(
          (value) => value.first.fold(
            (faleure) {},
            (success) {
              crew.add(success);
              notifyListeners();
            },
          ),
        );
      }
    }
  }

  List<CategoryModel> _getCraft(ProductModel product) {
    final List<CategoryModel> craft;
    craft = product.categories.where((e) => e.isCraft == true).toList();
    return craft;
  }

  List<CategoryModel> _getCrew(ProductModel product) {
    final List<CategoryModel> craft;
    craft = product.categories.where((e) => e.isCraft == false).toList();
    return craft;
  }

  void clear() {
    products.clear();
    _detailsRepo.clearDoc();
    craft.clear();
    crew.clear();
  }
}
