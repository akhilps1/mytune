// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:mytune/features/home/models/product_model.dart';

@lazySingleton
class TopThreeReleaseRepo {
  final FirebaseFirestore firebaseFirestore;
  TopThreeReleaseRepo({
    required this.firebaseFirestore,
  });
  QuerySnapshot<Map<String, dynamic>>? ref;

  Future<List<ProductModel>> getTopThreeRelease() async {
    final List<ProductModel> products = [];

    try {
      ref = await firebaseFirestore
          .collection('products')
          .where(
            'isTopThree',
            isEqualTo: true,
          )
          .orderBy('timestamp')
          .get();

      products.addAll(
        ref!.docs.map(
          (e) => ProductModel.fromFireStore(e),
        ),
      );
      return products;
    } catch (e) {
      log('Top three: ${e.toString()}');
      return [];
    }

    // log(users.length.toString());
  }
}
