// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../general/failures/main_failure.dart';
import '../../home/models/category_model.dart';

@lazySingleton
class CrewDetailRepo {
  final FirebaseFirestore firebaseFirestore;
  CrewDetailRepo({
    required this.firebaseFirestore,
  });

  Future<Either<MainFailure, CategoryModel>> getCrew(
      {required String categoryId}) async {
    DocumentSnapshot<Map<String, dynamic>> refreshedClass;

    try {
      refreshedClass = await firebaseFirestore
          .collection('categories')
          .doc(categoryId)
          .get();

      return right(CategoryModel.fromMap(refreshedClass.data()!).copyWith(
        id: refreshedClass.id,
      ));
    } catch (e) {
      print(e);
      return left(const MainFailure.noElemet(errorMsg: ''));
    }
  }
}
