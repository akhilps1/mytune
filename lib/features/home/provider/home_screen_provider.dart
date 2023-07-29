// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mytune/features/home/models/category_model.dart';
import 'package:mytune/features/home/models/product_model.dart';

import 'package:mytune/features/home/repository/category_repository.dart';
import 'package:mytune/features/home/repository/top_3_repository.dart';
import 'package:mytune/general/serveices/custom_toast.dart';

import '../../../general/di/injection.dart';
import '../../../general/failures/main_failure.dart';
import '../models/banner_model.dart';
import '../repository/all_products_repository.dart';
import '../repository/banner_reopsitory.dart';
import '../repository/today_release_repository.dart';

@injectable
class HomeScreenProvider with ChangeNotifier {
  final BannerRepository bannerRepository;
  final CategoryRepository categoryRepository;
  final TodayReleaseRepository todayReleaseRepository;
  final TopThreeReleaseRepo topThreeReleaseRepo =
      locater<TopThreeReleaseRepo>();

  final AllProductsRepo allProductsRepo = locater<AllProductsRepo>();
  HomeScreenProvider({
    required this.bannerRepository,
    required this.categoryRepository,
    required this.todayReleaseRepository,
  });

  List<BannerModel> banner = [];
  List<CategoryModel> categories = [];
  List<ProductModel> todayRelease = [];
  List<ProductModel> topThreeRelease = [];
  List<ProductModel> allProducts = [];

  bool isLoading = false;
  bool isFirebaseLoading = false;
  bool noMoreData = false;

  Future<void> getDetails() async {
    Either<MainFailure, List<ProductModel>> failureOrSuccess;
    Either<MainFailure, List<CategoryModel>> failureOrSuccessArtist;
    isLoading = true;
    notifyListeners();
    await Future.wait(
      [
        bannerRepository.getDetialsFromFirebase(),
        categoryRepository.getCategoriesByLimit(),
        todayReleaseRepository.getTodaysReleaseByLimit(),
        topThreeReleaseRepo.getTopThreeRelease(),
        allProductsRepo.getAllProductsByLimit(),
      ],
    ).then((value) {
      // print(value);
      banner = value[0] as List<BannerModel>;
      failureOrSuccessArtist =
          value[1] as Either<MainFailure, List<CategoryModel>>;
      todayRelease = value[2] as List<ProductModel>;
      topThreeRelease = value[3] as List<ProductModel>;
      failureOrSuccess = value[4] as Either<MainFailure, List<ProductModel>>;

      failureOrSuccess.fold(
        (failure) {
          CustomToast.errorToast('Nothig to show');
        },
        (success) => allProducts = success,
      );

      failureOrSuccessArtist.fold(
        (failure) {
          CustomToast.errorToast('Nothig to show');
        },
        (success) => categories = success,
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

  Future<Either<MainFailure, List<CategoryModel>>>
      getAllArtistsByLimit() async {
    return await categoryRepository.getCategoriesByLimit();

    // print(products);
  }

  Future<void> followButtonClicked(
      {required CategoryModel categoryModel}) async {}
}
