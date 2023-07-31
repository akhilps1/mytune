// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../general/failures/main_failure.dart';
import '../../home/models/category_model.dart';

@lazySingleton
class CraftDetailRepo {
  final FirebaseFirestore firebaseFirestore;
  CraftDetailRepo({
    required this.firebaseFirestore,
  });

  Future<Either<MainFailure, CategoryModel>> getCraft(
      {required String categoryId}) async {
    DocumentSnapshot<Map<String, dynamic>> refreshedClass;
    // print(categoryId);

    try {
      refreshedClass = await firebaseFirestore
          .collection('categories')
          .doc(categoryId)
          .get();

      if (refreshedClass.data() != null) {
        return right(CategoryModel.fromMap(refreshedClass.data()!).copyWith(
          id: refreshedClass.id,
        ));
      } else {
        // print(refreshedClass.data());
        return left(const MainFailure.noElemet(errorMsg: ''));
      }
    } catch (e) {
      // print(e);
      return left(const MainFailure.noElemet(errorMsg: ''));
    }
  }
}
