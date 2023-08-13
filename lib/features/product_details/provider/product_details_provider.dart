import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:mytune/features/home/models/category_model.dart';
// import 'package:mytune/features/home/provider/local_db_data_provider.dart';
import 'package:mytune/general/di/injection.dart';
import 'package:mytune/general/serveices/custom_toast.dart';
import 'package:mytune/general/utils/enum/enums.dart';

import '../../../general/failures/main_failure.dart';
import '../../home/models/product_model.dart';
import '../repository/craft_details_repo.dart';
import '../repository/crew_detail_repo.dart';
import '../repository/product_details_repo.dart';

@injectable
class ProductDetailsProvider with ChangeNotifier {
  final ProductDetailsRepo _detailsRepo = locater<ProductDetailsRepo>();
  final CraftDetailRepo _craftDetailRepo = locater<CraftDetailRepo>();
  final CrewDetailRepo _crewDetailRepo = locater<CrewDetailRepo>();

  bool isLoading = false;
  bool isFirebaseLoading = false;
  bool noMoreData = false;
  bool? isLiked;

  List<ProductModel> products = [];

  List<CategoryModel> craft = [];
  List<CategoryModel> crew = [];

  Future<void> getProductsByLimit({
    required String categoryId,
    required String productId,
  }) async {
    // isFirebaseLoading = true;
    isLoading = true;
    notifyListeners();

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
        isLoading = false;
        isFirebaseLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> getCraft({required ProductModel product}) async {
    List<CategoryModel> list = _getCraft(product);

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
            (faleure) {},
            (success) {
              craft.add(success.copyWith(proffession: category.proffession));
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
              crew.add(success.copyWith(proffession: category.proffession));
              notifyListeners();
            },
          ),
        );
      }
    }
  }

  Future<void> checkLiked({
    required ProductModel product,
    required String userId,
  }) async {
    log('CheckLicked Called');

    log('CheckLicked  checked from server');
    Either<MainFailure, String> failureOrSuccess =
        await _detailsRepo.checkIsLiked(product: product, userId: userId);

    failureOrSuccess.fold(
      (failure) {
        isLiked = false;
        notifyListeners();
        log('Not liked');
      },
      (success) {
        isLiked = true;
        // _dbDataProvider.addeLikedVideos(id: success);
        log(' liked');
        notifyListeners();
      },
    );
  }

  void setLiked() {
    isLiked = true;
    notifyListeners();
  }

  Future<void> likeButtonClicked({required ProductModel video}) async {
    await _detailsRepo.likeClicked(
      video: video,
    );
    notifyListeners();
  }

  Future<void> unLikeButtonClicked({required ProductModel video}) async {
    await _detailsRepo.unlikeClicked(
      video: video,
    );
    notifyListeners();
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

  void updateLike({required String id, required CountState state}) {
    for (var element in products) {
      if (element.id == id) {
        switch (state) {
          case CountState.decrement:
            element.likes = element.likes + 1;
            notifyListeners();
            break;
          case CountState.increment:
            element.likes = element.likes - 1;
            notifyListeners();
            break;
        }
      }
    }
  }

  void updateView({required ProductModel product}) {
    log(product.likes.toString());
    for (var element in products) {
      if (element.id == product.id) {
        final view = element.views;
        element.views = view + 1;
        notifyListeners();
      }
    }
  }

  void clear() {
    products.clear();
    _detailsRepo.clearDoc();
    craft.clear();
    crew.clear();
    notifyListeners();
  }

  void clearCastAndCrew() {
    craft.clear();
    crew.clear();
  }

  void updateFollowers({required String id, required CountState state}) {
    for (var element in [...craft, ...crew]) {
      if (element.id == id) {
        switch (state) {
          case CountState.decrement:
            element.followers = element.followers - 1;
            break;
          case CountState.increment:
            element.followers = element.followers + 1;
            break;
        }
        notifyListeners();
      }
    }
  }
}
