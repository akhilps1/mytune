import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mytune/features/artist_details/repository/artist_details_repo.dart';
import 'package:mytune/features/home/models/category_model.dart';
import 'package:mytune/features/home/provider/local_db_data_provider.dart';
import 'package:mytune/general/di/injection.dart';
import 'package:mytune/general/failures/main_failure.dart';

import '../../../general/serveices/custom_toast.dart';
import '../../home/models/product_model.dart';

@injectable
class ArtistDetailsProvider with ChangeNotifier {
  final ArtistDetailsRepo _artistDetailsRepo = locater<ArtistDetailsRepo>();
  final LocalDbDataProvider _dbDataProvider = LocalDbDataProvider();

  bool isLoading = false;
  bool isFirebaseLoading = false;
  bool noMoreData = false;
  bool? isFollowed;

  List<ProductModel> products = [];

  Future<void> getProductsByLimit({required String categoryId}) async {
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

        isLoading = true;
        isFirebaseLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> checkFollowed(
      {required CategoryModel artist, required String userId}) async {
    // log('CheckLicked Called');
    if (_dbDataProvider.followedArtist.contains(artist.id)) {
      isFollowed = true;
      // print('CheckLicked  checked from local db');
      notifyListeners();
    } else {
      Either<MainFailure, String> failureOrSuccess = await _artistDetailsRepo
          .checkIsFollowed(artist: artist, userId: userId);

      failureOrSuccess.fold(
        (failure) {
          isFollowed = false;
          notifyListeners();
          // log('Not liked');
        },
        (success) {
          isFollowed = true;
          _dbDataProvider.addeLikedVideos(id: success);
          // log(' liked');
          notifyListeners();
        },
      );
    }
  }

  Future<void> followButtonClicked({required CategoryModel artist}) async {
    await _artistDetailsRepo.followClicked(artist: artist);
  }

  Future<void> unFollowButtonClicked({required CategoryModel artist}) async {
    await _artistDetailsRepo.unFollowClicked(artist: artist);
  }

  void clear() {
    products.clear();
    _artistDetailsRepo.clearDoc();
  }
}
