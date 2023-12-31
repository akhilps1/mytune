// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mytune/general/failures/main_failure.dart';

import '../models/product_model.dart';

@lazySingleton
class AllProductsRepo {
  final FirebaseFirestore firebaseFirestore;
  AllProductsRepo({
    required this.firebaseFirestore,
  });

  DocumentSnapshot<Map<String, dynamic>>? lastDoc;

  Future<Either<MainFailure, List<ProductModel>>>
      getAllProductsByLimit() async {
    QuerySnapshot<Map<String, dynamic>> refreshedClass;

    final List<ProductModel> products = [];

    try {
      refreshedClass = lastDoc == null
          ? await FirebaseFirestore.instance
              .collection('products')
              .orderBy('timestamp', descending: true)
              .where(
                'visibility',
                isEqualTo: true,
              )
              .limit(7)
              .get()
          : await FirebaseFirestore.instance
              .collection('products')
              .orderBy('timestamp', descending: true)
              .where(
                'visibility',
                isEqualTo: true,
              )
              .startAfterDocument(lastDoc!)
              .limit(4)
              .get();

      if (refreshedClass.docs.isNotEmpty) {
        lastDoc = refreshedClass.docs.last;
      } else {
        return left(const MainFailure.noElemet(errorMsg: ''));
      }

      if (refreshedClass.docs.length <= 7) {}
      products.addAll(
        refreshedClass.docs.map((e) {
          return ProductModel.fromFireStore(e);
        }),
      );
      // log(categories.toString());
      return right(products);
      // log(users.length.toString());
    } catch (e) {
      log('All products: ${e.toString()}');
      return left(
        const MainFailure.noElemet(errorMsg: 'Nothing to show'),
      );
    }
  }
}
