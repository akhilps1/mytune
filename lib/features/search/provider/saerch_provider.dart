import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mytune/features/home/models/category_model.dart';
import 'package:mytune/general/di/injection.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../general/failures/main_failure.dart';
import '../../../general/serveices/custom_toast.dart';
import '../../../general/utils/enum/enums.dart';
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
  bool isListen = false;
  String text = '';

  List<ProductModel> products = [];
  List<CategoryModel> categories = [];
  SpeechToText? speech;

  Future<void> searchProductsByLimit({required String productName}) async {
    Either<MainFailure, List<ProductModel>> failureOrSuccess;

    failureOrSuccess = await _productSearchRepo.searhProduct(
        productName: productName.replaceAll(' ', ''));

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

    failureOrSuccess = await _categorySearchRepo.searhCategory(
        categoryName: categoryName.replaceAll(' ', ''));

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

  Future<void> listen(SearchState searchState) async {
    speech = SpeechToText();
    if (text.isNotEmpty) {
      text = '';
    }
    if (!isListen) {
      bool avail = await speech!.initialize();
      if (avail) {
        isListen = true;
        notifyListeners();

        await speech!.listen(onResult: (value) async {
          print(value.recognizedWords);
          text = value.recognizedWords;
          if (searchState == SearchState.video) {
            await searchProductsByLimit(productName: value.recognizedWords);
          } else {
            await searchCategoryByLimit(categoryName: value.recognizedWords);
          }
          isListen = false;
          notifyListeners();

          await speech!.stop();
        });
      }
    } else {}
  }
}
