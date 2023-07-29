// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import 'package:mytune/features/home/models/category_model.dart';
import 'package:mytune/features/home/provider/home_screen_provider.dart';

import '../../../general/failures/main_failure.dart';
import '../../../general/serveices/custom_toast.dart';

class ArtistScreenProvider with ChangeNotifier {
  final HomeScreenProvider homeScreenProvider;
  bool isLoading = false;
  bool isFirebaseLoading = false;
  bool noMoreData = false;

  List<CategoryModel> artists = [];
  ArtistScreenProvider(
    this.artists,
    this.homeScreenProvider,
  );

  Future<void> getAllArtistsByLimit() async {
    isLoading = false;
    isFirebaseLoading = false;
    notifyListeners();

    Either<MainFailure, List<CategoryModel>> failureOrSuccess;
    failureOrSuccess = await homeScreenProvider.getAllArtistsByLimit();

    failureOrSuccess.fold(
      (failure) {
        CustomToast.errorToast('Nothig to Show');
        noMoreData = true;
        isLoading = false;
        isFirebaseLoading = false;
        notifyListeners();
      },
      (success) {
        artists.addAll(success);
        isLoading = true;
        isFirebaseLoading = false;
        notifyListeners();
      },
    );
  }
}
