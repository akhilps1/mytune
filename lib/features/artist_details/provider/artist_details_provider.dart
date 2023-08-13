import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'package:mytune/features/artist_details/repository/artist_details_repo.dart';
import 'package:mytune/features/home/models/category_model.dart';

import 'package:mytune/general/di/injection.dart';
import 'package:mytune/general/failures/main_failure.dart';
import 'package:mytune/general/utils/enum/enums.dart';

import '../../../general/serveices/custom_toast.dart';
import '../../home/models/product_model.dart';

@injectable
class ArtistDetailsProvider with ChangeNotifier {
  final ArtistDetailsRepo _artistDetailsRepo = locater<ArtistDetailsRepo>();

  bool isLoading = false;
  bool isFirebaseLoading = false;
  bool noMoreData = false;
  bool? isFollowed;

  List<ProductModel> products = [];

  Future<void> getProductsByLimit({required String categoryId}) async {
    isLoading = true;
    notifyListeners();
    Either<MainFailure, List<ProductModel>> failureOrSuccess;

    failureOrSuccess =
        await _artistDetailsRepo.getProductsByLimit(categoryId: categoryId);

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

        isLoading = false;
        isFirebaseLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> followButtonClicked({required CategoryModel artist}) async {
    await _artistDetailsRepo.followClicked(artist: artist);
  }

  Future<void> unFollowButtonClicked({required CategoryModel artist}) async {
    await _artistDetailsRepo.unFollowClicked(artist: artist);
  }

  void updateLikes({required String id, required CountState state}) {
    for (var element in products) {
      if (element.id == id) {
        switch (state) {
          case CountState.decrement:
            element.likes = element.likes + 1;
            break;
          case CountState.increment:
            element.likes = element.likes - 1;
            break;
        }
        notifyListeners();
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
    _artistDetailsRepo.clearDoc();
  }
}
