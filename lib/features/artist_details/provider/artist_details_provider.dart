import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:mytune/features/artist_details/repository/artist_details_repo.dart';
import 'package:mytune/general/di/injection.dart';
import 'package:mytune/general/failures/main_failure.dart';

import '../../../general/serveices/custom_toast.dart';
import '../../home/models/product_model.dart';

@injectable
class ArtistDetailsProvider with ChangeNotifier {
  final ArtistDetailsRepo _artistDetailsRepo = locater<ArtistDetailsRepo>();

  bool isLoading = false;
  bool isFirebaseLoading = false;
  bool noMoreData = false;

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

  void clear() {
    products.clear();
    _artistDetailsRepo.clearDoc();
  }
}
