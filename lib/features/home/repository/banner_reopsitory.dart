// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../models/banner_model.dart';

@lazySingleton
class BannerRepository {
  final FirebaseFirestore firebaseFirestore;
  BannerRepository({
    required this.firebaseFirestore,
  });

  QuerySnapshot<Map<String, dynamic>>? ref;

  Future<List<BannerModel>> getDetialsFromFirebase() async {
    final List<BannerModel> banners = [];

    try {
      ref = await firebaseFirestore
          .collection('banner')
          .orderBy('timestamp')
          .get();
    } catch (e) {
      log(e.toString());
    }

    // log('BannerRepository : ${ref?.docs}');

    banners.addAll(
      ref!.docs.map(
        (e) => BannerModel.fromMap(e),
      ),
    );

    return banners;
  }
}
