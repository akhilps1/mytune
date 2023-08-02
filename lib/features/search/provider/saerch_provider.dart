import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mytune/features/home/models/category_model.dart';
import 'package:mytune/general/di/injection.dart';

import '../../../general/failures/main_failure.dart';
import '../../../general/serveices/custom_toast.dart';
import '../../home/models/product_model.dart';
import '../repository/category_search_repo.dart';
import '../repository/product_search_repo.dart';

@injectable
class SearchProvider with ChangeNotifier {
  final CategorySearchRepo _categorySearchRepo = locater<CategorySearchRepo>();
  final ProductSearchRepo _productSearchRepo = locater<ProductSearchRepo>();

  bool isLoading = false;
  bool isFirebaseLoading = false;
  bool noMoreData = false;

  List<ProductModel> products = [];
  List<CategoryModel> categories = [];

  Future<void> searchProductsByLimit({required String productName}) async {
    Either<MainFailure, List<ProductModel>> failureOrSuccess;

    failureOrSuccess =
        await _productSearchRepo.searhProduct(productName: productName);

    failureOrSuccess.fold(
      (failure) {
        CustomToast.errorToast('Nothig to Show');
        noMoreData = true;
        isLoading = false;
        isFirebaseLoading = false;
        notifyListeners();
      },
      (success) {
        products.addAll(success);
        isLoading = true;
        isFirebaseLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> searchCategoryByLimit({required String categoryName}) async {
    Either<MainFailure, List<CategoryModel>> failureOrSuccess;

    failureOrSuccess =
        await _categorySearchRepo.searhCategory(categoryName: categoryName);

    failureOrSuccess.fold(
      (failure) {
        CustomToast.errorToast('Nothig to Show');
        noMoreData = true;
        isLoading = false;
        isFirebaseLoading = false;
        notifyListeners();
      },
      (success) {
        categories.addAll(success);
        isLoading = true;
        isFirebaseLoading = false;
        notifyListeners();
      },
    );
  }

  void clear() {
    products.clear();
    categories.clear();
    _productSearchRepo.clearDoc();
    _categorySearchRepo.clearDoc();
    notifyListeners();
  }
}
