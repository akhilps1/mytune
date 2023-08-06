import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:mytune/general/failures/main_failure.dart';

import '../../home/models/product_model.dart';

@lazySingleton
class ArtistDetailsRepo {
  final FirebaseFirestore firebaseFirestore;

  ArtistDetailsRepo({
    required this.firebaseFirestore,
  });

  DocumentSnapshot<Map<String, dynamic>>? lastDoc;

  Future<Either<MainFailure, List<ProductModel>>> getProductsByLimit(
      {required String categoryId}) async {
    QuerySnapshot<Map<String, dynamic>> refreshedClass;

    final List<ProductModel> products = [];

    try {
      refreshedClass = lastDoc == null
          ? await FirebaseFirestore.instance
              .collection('products')
              .orderBy('timestamp', descending: true)
              .where(
                'categoryId',
                isEqualTo: categoryId,
              )
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
                'categoryId',
                isEqualTo: categoryId,
              )
              .where(
                'visibility',
                isEqualTo: true,
              )
              .startAfterDocument(lastDoc!)
              .limit(4)
              .get();

      if (refreshedClass.docs.isNotEmpty) {
        lastDoc = refreshedClass.docs.last;
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

  void clearDoc() {
    lastDoc = null;
  }
}
