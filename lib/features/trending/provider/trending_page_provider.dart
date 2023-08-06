import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mytune/features/home/models/product_model.dart';
import 'package:mytune/general/di/injection.dart';

import '../../../general/serveices/custom_toast.dart';
import '../repository/trending_repo.dart';

@injectable
class TrendingPageProvider with ChangeNotifier {
  bool isLoading = false;
  bool isFirebaseLoading = false;
  bool noMoreData = false;

  List<ProductModel> trendingVieos = [];

  final TrendingPageRepo _trendingPageRepo = locater<TrendingPageRepo>();

  Future<void> getTrendingByLimite() async {
    final failureOrSuccess =
        await _trendingPageRepo.getTrendingReleaseByLimit();

    failureOrSuccess.fold(
      (failure) {
        CustomToast.errorToast('Nothig to Show');
        noMoreData = true;
        isLoading = false;
        isFirebaseLoading = false;
        notifyListeners();
      },
      (success) {
        trendingVieos.addAll(success);
        isLoading = true;
        isFirebaseLoading = false;
        print(success);
        notifyListeners();
      },
    );
  }
}
