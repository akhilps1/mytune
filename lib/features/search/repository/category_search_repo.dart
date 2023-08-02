// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mytune/features/home/models/category_model.dart';
import 'package:mytune/general/failures/main_failure.dart';

@lazySingleton
class CategorySearchRepo {
  final FirebaseFirestore firebaseFirestore;

  CategorySearchRepo({
    required this.firebaseFirestore,
  });

  QueryDocumentSnapshot<Map<String, dynamic>>? lastDoc;

  Future<Either<MainFailure, List<CategoryModel>>> searhCategory({
    required String categoryName,
  }) async {
    QuerySnapshot<Map<String, dynamic>> refreshedClass;
    List<CategoryModel> list = [];
    try {
      refreshedClass = lastDoc == null
          ? await firebaseFirestore
              .collection('categories')
              .orderBy('timestamp')
              .where(
                'keywords',
                arrayContains: categoryName,
              )
              .limit(7)
              .get()
          : await firebaseFirestore
              .collection('categories')
              .orderBy('timestamp')
              .where(
                'keywords',
                arrayContains: categoryName,
              )
              .startAfterDocument(lastDoc!)
              .limit(4)
              .get();

      lastDoc = refreshedClass.docs.last;

      // if (refreshedClass.docs.length <= 7) {
      //   log('category doc lrnth lessthan 7');
      // }
      log('document: ${refreshedClass.docs.toString()}');

      list.addAll(
        refreshedClass.docs.map((e) {
          return CategoryModel.fromFireStore(e);
        }),
      );
      return right(list);
    } catch (e) {
      log('CATEGORY SEARCH FAILURE : $e');
      return left(const MainFailure.noElemet(errorMsg: ''));
    }
  }

  void clearDoc() {
    lastDoc = null;
  }
}
