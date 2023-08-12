import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:mytune/features/favorate/repository/favorate_repo.dart';
import 'package:mytune/features/home/models/product_model.dart';
import 'package:mytune/general/di/injection.dart';
import 'package:mytune/general/failures/main_failure.dart';
import 'package:mytune/general/utils/enum/enums.dart';

@injectable
class FavorateProvider with ChangeNotifier {
  final FavorateRepo _favorateRepo = locater<FavorateRepo>();

  bool isLoading = false;
  bool isFirebaseLoading = false;
  bool noMoreData = false;
  bool? isFollowed;

  int start = 0;
  int end = 5;
  int batchSize = 5;

  List<ProductModel> savedVideos = [];

  Future<void> saveClicked({required ProductModel video}) async {
    savedVideos.insert(0, video);
    await _favorateRepo.saveClicked(video: video);
    notifyListeners();
  }

  Future<void> removeSaveClicked({required ProductModel video}) async {
    savedVideos =
        savedVideos.where((element) => element.id != video.id).toList();
    await _favorateRepo.unSaveClicked(video: video);
    notifyListeners();
  }

  Future<void> getSavedVideos({required List videoIds}) async {
    if (!isLoading && !noMoreData) {
      isLoading = true;
      notifyListeners();

      List idsToFetch = getIdsForNextBatch(videoIds);

      if (idsToFetch.isNotEmpty) {
        Either<MainFailure, List<ProductModel>> failureOrSuccess =
            await _favorateRepo.getFavorates(videoIds: idsToFetch);

        failureOrSuccess.fold(
          (l) {
            // Handle failure
          },
          (newVideos) {
            if (newVideos.isNotEmpty) {
              savedVideos.addAll(newVideos);
              start += batchSize;
              end += batchSize;
            } else {
              noMoreData = true;
            }
          },
        );

        isLoading = false;
        notifyListeners();
      }
    }
  }

  void updateLikes({required String id, required CountState state}) {
    for (var element in savedVideos) {
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
    for (var element in savedVideos) {
      if (element.id == product.id) {
        final view = element.views;
        element.views = view + 1;
        notifyListeners();
      }
    }
  }

  List getIdsForNextBatch(List videoIds) {
    int remainingVideos = videoIds.length - start;
    int videosToFetch =
        remainingVideos > batchSize ? batchSize : remainingVideos;

    try {
      List idsToFetch = videoIds.sublist(start, start + videosToFetch);
      return idsToFetch;
    } catch (e) {
      noMoreData = true;
      notifyListeners();
      return [];
    }
  }
}
