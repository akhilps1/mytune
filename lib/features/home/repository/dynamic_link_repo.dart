// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:injectable/injectable.dart';
import 'package:mytune/features/home/models/product_model.dart';
import 'package:mytune/general/failures/main_failure.dart';

@lazySingleton
class DynamicLinkRepo {
  final FirebaseFirestore firebaseFirestore;
  DynamicLinkRepo({
    required this.firebaseFirestore,
  });

  Future<Either<MainFailure, ProductModel>> getDynamicLinkProduct(
      PendingDynamicLinkData data) async {
    String? productid = data.link.queryParameters["productid"];

    try {
      DocumentSnapshot<Map<String, dynamic>> element =
          await firebaseFirestore.collection("products").doc(productid).get();

      return right(
        ProductModel.fromMap(element.data()!).copyWith(id: element.id),
      );
    } catch (e) {
      return left(const MainFailure.serverFailure());
    }
  }
}
