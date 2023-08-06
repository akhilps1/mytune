import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../general/failures/main_failure.dart';
import '../../home/models/product_model.dart';

@lazySingleton
class ProductDetailsRepo {
  final FirebaseFirestore firebaseFirestore;
  ProductDetailsRepo({
    required this.firebaseFirestore,
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

  // Future<void> addLike() async{
  //  firebaseFirestore.collection('users').
  // }

  void clearDoc() {
    lastDoc = null;
  }
}
