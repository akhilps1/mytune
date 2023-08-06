// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:mytune/features/home/models/category_model.dart';

@lazySingleton
class ArtistRepo {
  final FirebaseFirestore firebaseFirestore;
  ArtistRepo({
    required this.firebaseFirestore,
  });

  Future<List<CategoryModel>> fetchSingers() async {
    List<CategoryModel> data;
    final refreshedClass = await firebaseFirestore
        .collection('categories')
        .orderBy('timestamp')
        .limit(3)
        .get();

    if (refreshedClass.docs.isEmpty) {
      return [];
    } else {
      data = refreshedClass.docs
          .map((e) => CategoryModel.fromFireStore(e))
          .toList();
      return data;
    }
  }
}
