// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import 'package:mytune/features/home/models/category_model.dart';
import 'package:mytune/general/failures/main_failure.dart';

@lazySingleton
class CategoryRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  QueryDocumentSnapshot<Map<String, dynamic>>? lastDoc;
  CategoryRepository({
    required this.firebaseFirestore,
    required this.firebaseAuth,
  });

  Future<void> searchCategoryByLimit() async {}

  Future<Either<MainFailure, List<CategoryModel>>>
      getCategoriesByLimit() async {
    List<CategoryModel> categories = [];
    QuerySnapshot<Map<String, dynamic>> refreshedClass;
    try {
      refreshedClass = lastDoc == null
          ? await firebaseFirestore
              .collection('categories')
              .orderBy('timestamp', descending: true)
              .where(
                'visibility',
                isEqualTo: true,
              )
              .limit(7)
              .get()
          : await firebaseFirestore
              .collection('categories')
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

      // log('getCategoriesByLimit: ${refreshedClass.docs.toString()}');

      categories.addAll(
        refreshedClass.docs.map((e) {
          return CategoryModel.fromFireStore(e);
        }),
      );
      // log(categories.toString());
      return right(categories);
      // log(users.length.toString());
    } catch (e) {
      print(e.toString());
      return left(const MainFailure.noElemet(errorMsg: ''));
    }
  }

  Future<Either<MainFailure, Unit>> followClicked(
      {required CategoryModel categoryModel}) async {
    DocumentSnapshot<Map<String, dynamic>> ref;

    final userId = firebaseAuth.currentUser?.uid;

    if (userId != null) {
      ref = await firebaseFirestore.collection('users').doc(userId).get();
    }

    return right(unit);
  }
}
