// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import 'package:mytune/features/home/models/category_model.dart';

@lazySingleton
class CategoryRepository {
  final FirebaseFirestore firebaseFirestore;

  QueryDocumentSnapshot<Map<String, dynamic>>? lastDoc;
  CategoryRepository({
    required this.firebaseFirestore,
  });

  Future<void> searchCategoryByLimit() async {}

  Future<List<CategoryModel>> getCategoriesByLimit() async {
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

      // log('getCategoriesByLimit: ${refreshedClass.docs.toString()}');

      categories.addAll(
        refreshedClass.docs.map((e) {
          return CategoryModel.fromFireStore(e);
        }),
      );
      // log(categories.toString());
      return categories;
      // log(users.length.toString());
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
