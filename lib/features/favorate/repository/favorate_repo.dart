// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import 'package:mytune/features/home/models/product_model.dart';
import 'package:mytune/general/failures/main_failure.dart';

@lazySingleton
class FavorateRepo {
  final FirebaseFirestore firebaseFirestore;
  FavorateRepo({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  final FirebaseAuth firebaseAuth;

  DocumentSnapshot<Map<String, dynamic>>? lastDoc;

  Future<Either<MainFailure, List<ProductModel>>> getFavorates(
      {required List videoIds}) async {
    List<ProductModel> products = [];
    List<Future<DocumentSnapshot<Map<String, dynamic>>>> list = [];

    log(videoIds.toString());

    for (String element in videoIds) {
      Future<DocumentSnapshot<Map<String, dynamic>>> data =
          firebaseFirestore.collection('products').doc(element).get();

      list.add(data);
    }
    products = await Future.wait(list).then((value) {
      return value
          .map(
            (e) => ProductModel.fromMap(e.data()!).copyWith(
              id: e.id,
            ),
          )
          .toList();
    });

    log(products.length.toString());

    return right(products);
  }

  Future<Either<MainFailure, Unit>> saveClicked(
      {required ProductModel video}) async {
    try {
      await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .update({
        'favoriteVideos': FieldValue.arrayUnion([video.id])
      });

      return right(unit);
    } catch (e) {
      return left(const MainFailure.serverFailure());
    }
  }

  Future<Either<MainFailure, Unit>> unSaveClicked(
      {required ProductModel video}) async {
    try {
      await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .update({
        'favoriteVideos': FieldValue.arrayRemove([video.id])
      });

      return right(unit);
    } catch (e) {
      return left(const MainFailure.serverFailure());
    }
  }

  void clearDoc() {
    lastDoc = null;
  }
}
