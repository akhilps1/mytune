// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'package:mytune/features/home/models/category_model.dart';

import 'package:mytune/general/di/injection.dart';
import 'package:mytune/general/utils/enum/enums.dart';

import '../../../general/failures/main_failure.dart';
import '../../../general/serveices/custom_toast.dart';
import '../repository/category_repository.dart';

@injectable
class ArtistScreenProvider with ChangeNotifier {
  final CategoryRepository _categoryRepository = locater<CategoryRepository>();

  bool isLoading = false;
  bool isFirebaseLoading = false;
  bool noMoreData = false;

  List<CategoryModel> artists = [];

  Future<void> getAllArtistsByLimit() async {
    isLoading = false;
    isFirebaseLoading = false;
    notifyListeners();

    Either<MainFailure, List<CategoryModel>> failureOrSuccess;

    failureOrSuccess = await _categoryRepository.getCategoriesByLimit();

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

        isLoading = false;
        isFirebaseLoading = false;
        notifyListeners();
      },
    );
  }

  void updateFollowers({required String id, required CountState state}) {
    for (var element in artists) {
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
