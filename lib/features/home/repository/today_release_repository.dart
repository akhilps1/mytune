// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import 'package:mytune/features/home/models/product_model.dart';

@lazySingleton
class TodayReleaseRepository {
  final FirebaseFirestore firebaseFirestore;
  TodayReleaseRepository({
    required this.firebaseFirestore,
  });

  DocumentSnapshot<Map<String, dynamic>>? lastDoc;
  Future<List<ProductModel>> getTodaysReleaseByLimit() async {
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
                'isTodayRelease',
                isEqualTo: true,
              )
              .limit(7)
              .get()
          : await firebaseFirestore
              .collection('products')
              .orderBy('timestamp', descending: true)
              .where(
                'visibility',
                isEqualTo: true,
              )
              .where(
                'isTodayRelease',
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
      return products;
      // log(users.length.toString());
    } catch (e) {
      log('Today Release: ${e.toString()}');
      return [];
    }
  }
}
