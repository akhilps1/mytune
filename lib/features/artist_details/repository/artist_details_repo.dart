// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import 'package:mytune/features/home/models/category_model.dart';
import 'package:mytune/general/failures/main_failure.dart';

import '../../home/models/product_model.dart';

@lazySingleton
class ArtistDetailsRepo {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  ArtistDetailsRepo({
    required this.firebaseFirestore,
    required this.firebaseAuth,
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

  Future<Either<MainFailure, Unit>> followClicked(
      {required CategoryModel artist}) async {
    try {
      firebaseFirestore.collection('categories').doc(artist.id).update({
        'followers': FieldValue.increment(1),
      });

      await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('follwedArtist')
          .add({
        'artistId': artist.id,
      });

      return right(unit);
    } catch (e) {
      return left(const MainFailure.serverFailure());
    }
  }

  Future<Either<MainFailure, Unit>> unFollowClicked(
      {required CategoryModel artist}) async {
    try {
      await firebaseFirestore.collection('categories').doc(artist.id).update({
        'followers': FieldValue.increment(-1),
      });
      await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('follwedArtist')
          .add({
        'artistId': artist.id,
      });

      return right(unit);
    } catch (e) {
      return left(const MainFailure.serverFailure());
    }
  }

  Future<Either<MainFailure, String>> checkIsFollowed(
      {required CategoryModel artist, required String userId}) async {
    QuerySnapshot<Map<String, dynamic>> data;

    try {
      data = await firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('follwedArtist')
          .where('artistId', isEqualTo: artist.id)
          .get();

      // print(data.docs.toString());
      if (data.docs.isNotEmpty) {
        print('checkIsFollowed worked');

        return right(data.docs.first.data()['artistId']);
      } else {
        log('worked else');
        return left(const MainFailure.documentNotFount());
      }
    } catch (e) {
      log(e.toString());
      return left(const MainFailure.documentNotFount());
    }
  }

  void clearDoc() {
    lastDoc = null;
  }
}
