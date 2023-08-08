// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mytune/features/artist_details/provider/artist_details_provider.dart';
import 'package:mytune/features/authentication/provider/login_provider.dart';
import 'package:mytune/features/home/provider/local_db_data_provider.dart';

import 'package:mytune/general/serveices/custom_toast.dart';
import 'package:mytune/general/utils/enum/enums.dart';

import '../../../general/di/injection.dart';
import '../../../general/failures/main_failure.dart';
import '../../product_details/screens/product_details_page.dart';
import '../models/banner_model.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import '../repository/all_products_repository.dart';
import '../repository/artists_repo.dart';
import '../repository/banner_reopsitory.dart';
import '../repository/dynamic_link_repo.dart';
import '../repository/today_release_repository.dart';
import '../repository/top_3_repository.dart';

@injectable
class HomeScreenProvider with ChangeNotifier {
  final BannerRepository bannerRepository = locater<BannerRepository>();
  final ArtistRepo categoryRepository = locater<ArtistRepo>();
  final TodayReleaseRepository todayReleaseRepository =
      locater<TodayReleaseRepository>();
  final TopThreeReleaseRepo topThreeReleaseRepo =
      locater<TopThreeReleaseRepo>();

  final AllProductsRepo allProductsRepo = locater<AllProductsRepo>();

  final DynamicLinkRepo _dynamicLinkRepo = locater<DynamicLinkRepo>();
  final ArtistDetailsProvider _artistDetailsProvider =
      locater<ArtistDetailsProvider>();

  final LoginProvider loginProvider = locater<LoginProvider>();

  List<BannerModel> banner = [];
  List<CategoryModel> categories = [];
  List<ProductModel> todayRelease = [];
  List<ProductModel> topThreeRelease = [];
  List<ProductModel> allProducts = [];
  ProductModel? video;

  bool isLoading = false;
  bool isFirebaseLoading = false;
  bool noMoreData = false;

  Future<void> getDetails() async {
    Either<MainFailure, List<ProductModel>> failureOrSuccess;

    isLoading = true;
    notifyListeners();

    await Future.wait(
      [
        bannerRepository.getDetialsFromFirebase(),
        categoryRepository.fetchSingers(),
        todayReleaseRepository.getTodaysReleaseByLimit(),
        topThreeReleaseRepo.getTopThreeRelease(),
        allProductsRepo.getAllProductsByLimit(),
      ],
    ).then((value) {
      // print(value);
      banner = value[0] as List<BannerModel>;
      categories = value[1] as List<CategoryModel>;
      todayRelease = value[2] as List<ProductModel>;
      topThreeRelease = value[3] as List<ProductModel>;
      failureOrSuccess = value[4] as Either<MainFailure, List<ProductModel>>;

      failureOrSuccess.fold(
        (failure) {
          CustomToast.errorToast('Nothig to show');
        },
        (success) => allProducts = success,
      );

      isLoading = true;
      notifyListeners();
    });
  }

  Future<void> getAllProductsByLimit() async {
    log('getAllProductsByLimit() called');
    isLoading = true;
    isFirebaseLoading = true;
    notifyListeners();
    final failureOrSuccess = await allProductsRepo.getAllProductsByLimit();

    // print(products);
    failureOrSuccess.fold(
      (failure) {
        CustomToast.errorToast('Nothig to Show');
        noMoreData = true;
        isLoading = false;
        isFirebaseLoading = false;
        notifyListeners();
      },
      (success) {
        allProducts.addAll(success);
        isLoading = true;
        isFirebaseLoading = false;

        notifyListeners();
      },
    );
  }

  Future<void> getDynamicLinkProduct(
      {required PendingDynamicLinkData data,
      required BuildContext context}) async {
    final Either<MainFailure, ProductModel> successOrFailure =
        await _dynamicLinkRepo.getDynamicLinkProduct(data);

    successOrFailure.fold(
      (l) => print(l),
      (r) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetailsPage(product: r),
          ),
        );
      },
    );
  }

  void updateView({required ProductModel product}) {
    log(product.likes.toString());
    for (var element in [...allProducts, ...todayRelease, ...topThreeRelease]) {
      if (element.id == product.id) {
        final view = element.views;
        element.views = view + 1;
        notifyListeners();
      }
    }
  }

  void updateLikes({required String id, required CountState state}) {
    for (var element in [...allProducts, ...todayRelease, ...topThreeRelease]) {
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
}
