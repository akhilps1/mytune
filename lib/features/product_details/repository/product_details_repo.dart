// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../general/failures/main_failure.dart';
import '../../home/models/product_model.dart';

@lazySingleton
class ProductDetailsRepo {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  ProductDetailsRepo({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  DocumentSnapshot<Map<String, dynamic>>? lastDoc;

  Future<Either<MainFailure, List<ProductModel>>> getProductsByLimit({
    required String categoryId,
  }) async {
    QuerySnapshot<Map<String, dynamic>> refreshedClass;

    final List<ProductModel> products = [];

    try {
      refreshedClass = lastDoc == null
          ? await firebaseFirestore
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
          : await firebaseFirestore
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
      log('Related products: ${e.toString()}');
      return left(
        const MainFailure.noElemet(errorMsg: 'Nothing to show'),
      );
    }
  }

  Future<Either<MainFailure, Unit>> updateViews({required String id}) async {
    try {
      await firebaseFirestore.collection('products').doc(id).update({
        'views': FieldValue.increment(1),
      });

      return right(unit);
    } catch (e) {
      return left(const MainFailure.serverFailure());
    }
  }

  Future<Either<MainFailure, Unit>> likeClicked({
    required ProductModel video,
  }) async {
    try {
      await firebaseFirestore.collection('products').doc(video.id).update({
        'likes': FieldValue.increment(1),
      });
      await firebaseFirestore
          .collection('categories')
          .doc(video.categoryId)
          .update({
        'totalLikes': FieldValue.increment(1),
      });

      await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('likedVideos')
          .doc(video.id)
          .set({
        'videoId': video.id,
      });

      return right(unit);
    } catch (e) {
      return left(const MainFailure.serverFailure());
    }
  }

  Future<Either<MainFailure, Unit>> unlikeClicked(
      {required ProductModel video}) async {
    try {
      await firebaseFirestore.collection('products').doc(video.id).update({
        'likes': FieldValue.increment(-1),
      });
      await firebaseFirestore
          .collection('categories')
          .doc(video.categoryId)
          .update({
        'totalLikes': FieldValue.increment(-1),
      });
      await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('likedVideos')
          .doc(video.id)
          .delete();

      return right(unit);
    } catch (e) {
      return left(const MainFailure.serverFailure());
    }
  }

  Future<Either<MainFailure, String>> checkIsLiked(
      {required ProductModel product, required String userId}) async {
    DocumentSnapshot<Map<String, dynamic>> data;

    try {
      data = await firebaseFirestore
          .collection('users')
          .doc(userId)
          .collection('likedVideos')
          .doc(product.id)
          .get();

      // print(data.docs.toString());
      if (data.exists) {
        // print('checkIsLiked worked');

        return right(data.id);
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
