import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mytune/features/home/models/product_model.dart';
import 'package:mytune/general/di/injection.dart';
import 'package:mytune/general/utils/enum/enums.dart';

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

  void updateView({required ProductModel product}) {
    for (var element in trendingVieos) {
      if (element.id == product.id) {
        final view = element.views;
        element.views = view + 1;
        notifyListeners();
      }
    }
  }

  void updateLikes({required String id, required CountState state}) {
    for (var element in trendingVieos) {
      if (element.id == id) {
        switch (state) {
          case CountState.decrement:
            element.likes = element.likes + 1;
            notifyListeners();
            break;
          case CountState.increment:
            element.likes = element.likes - 1;
            notifyListeners();
            break;
        }
      }
    }
  }
}
