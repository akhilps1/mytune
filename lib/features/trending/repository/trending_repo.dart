// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mytune/features/home/models/product_model.dart';
import 'package:mytune/general/failures/main_failure.dart';

@lazySingleton
class TrendingPageRepo {
  final FirebaseFirestore firebaseFirestore;
  TrendingPageRepo({
    required this.firebaseFirestore,
  });

  DocumentSnapshot<Map<String, dynamic>>? lastDoc;

  Future<Either<MainFailure, List<ProductModel>>>
      getTrendingReleaseByLimit() async {
    QuerySnapshot<Map<String, dynamic>> refreshedClass;

    final List<ProductModel> products = [];

    try {
      refreshedClass = lastDoc == null
          ? await firebaseFirestore
              .collection('products')
              .orderBy('timestamp', descending: true)
              .where(
                'visibility',
                isEqualTo: true,
              )
              .where(
                'isTrending',
                isEqualTo: true,
              )
              .limit(10)
              .get()
          : await firebaseFirestore
              .collection('products')
              .orderBy('timestamp', descending: true)
              .where(
                'visibility',
                isEqualTo: true,
              )
              .where(
                'isTrending',
                isEqualTo: true,
              )
              .startAfterDocument(lastDoc!)
              .limit(7)
              .get();

      if (refreshedClass.docs.length <= 10) {}
      log('Trending: ${refreshedClass.toString()}');
      products.addAll(
        refreshedClass.docs.map((e) {
          return ProductModel.fromFireStore(e);
        }),
      );
      if (refreshedClass.docs.isNotEmpty) {
        lastDoc = refreshedClass.docs.last;
      } else {
        return left(const MainFailure.noElemet(errorMsg: ''));
      }
      // log(categories.toString());
      return right(products);
      // log(users.length.toString());
    } catch (e) {
      log('Trending: ${e.toString()}');
      return left(const MainFailure.serverFailure());
    }
  }
}
