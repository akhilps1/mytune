import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mytune/features/artist_details/repository/artist_details_repo.dart';
import 'package:mytune/features/home/models/category_model.dart';
import 'package:mytune/features/home/models/product_model.dart';

import 'package:mytune/features/product_details/repository/product_details_repo.dart';
import 'package:mytune/general/di/injection.dart';
import 'package:mytune/general/failures/main_failure.dart';
import 'package:mytune/general/local_db/local_db.dart';

@injectable
class LocalDbDataProvider with ChangeNotifier {
  List likedVideos = [];
  List followedArtist = [];

  final LocalDb _localDb = LocalDb<String>();
  final ProductDetailsRepo _detailsRepo = locater<ProductDetailsRepo>();
  final ArtistDetailsRepo _artistDetailsRepo = locater<ArtistDetailsRepo>();

  void getLikedVideos() async {
    likedVideos = await _localDb.get(localDbName: 'likedvideos-db');
    log('likedVideos $likedVideos');
    notifyListeners();
  }

  void addeLikedVideos({required String id}) async {
    await _localDb.insert(id, localDbName: 'likedvideos-db');
    likedVideos.add(id);
    notifyListeners();
  }

  void deleteLikedVideos({required String id}) async {
    await _localDb.onDelete(id, localDbName: 'likedvideos-db');
    dynamic video = likedVideos.firstWhere((element) => element == id);
    likedVideos.remove(video);
    notifyListeners();
  }

  void getFollowedArtist() async {
    followedArtist = await _localDb.get(localDbName: 'followedArtist-db');
    log('followedArtist $followedArtist');
  }

  void addFollowedArtist({required String id}) async {
    await _localDb.insert(id, localDbName: 'followedArtist-db');
    followedArtist.add(id);
    notifyListeners();
  }

  void deleteFollowedArtist({
    required String id,
  }) async {
    await _localDb.onDelete(id, localDbName: 'followedArtist-db');
    dynamic video = followedArtist.firstWhere((element) => element == id);
    followedArtist.remove(video);
    notifyListeners();
  }

  void deleteAllData() async {
    await _localDb.clearAll(localDbName: 'followedArtist-db');
    await _localDb.clearAll(localDbName: 'likedvideos-db');

    likedVideos.clear();
    followedArtist.clear();

    notifyListeners();
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
      (failure) {},
      (success) {
        addeLikedVideos(id: success);
        log(' liked');
        notifyListeners();
      },
    );
  }

  Future<void> checkFollowed(
      {required CategoryModel artist, required String userId}) async {
    log('call followed from server');
    Either<MainFailure, String> failureOrSuccess = await _artistDetailsRepo
        .checkIsFollowed(artist: artist, userId: userId);

    failureOrSuccess.fold(
      (failure) {
        log('Not followed');
      },
      (success) {
        // addFollowedArtist();
        log(' followed');
        notifyListeners();
      },
    );
  }
}
