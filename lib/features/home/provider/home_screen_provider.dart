// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mytune/features/home/models/category_model.dart';
import 'package:mytune/features/home/models/product_model.dart';

import 'package:mytune/features/home/repository/category_repository.dart';
import 'package:mytune/features/home/repository/top_3_repository.dart';

import '../../../general/di/injection.dart';
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

  Future<void> getDetails() async {
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
      categories = value[1] as List<CategoryModel>;
      todayRelease = value[2] as List<ProductModel>;
      topThreeRelease = value[3] as List<ProductModel>;
      allProducts = value[4] as List<ProductModel>;

      notifyListeners();
    });
  }
}
