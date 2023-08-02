// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mytune/features/home/models/product_model.dart';
import 'package:mytune/general/failures/main_failure.dart';

@lazySingleton
class ProductSearchRepo {
  final FirebaseFirestore firebaseFirestore;

  ProductSearchRepo({
    required this.firebaseFirestore,
  });

  QueryDocumentSnapshot<Map<String, dynamic>>? lastDoc;

  Future<Either<MainFailure, List<ProductModel>>> searhProduct({
    required String productName,
  }) async {
    QuerySnapshot<Map<String, dynamic>> refreshedClass;
    List<ProductModel> list = [];
    try {
      refreshedClass = lastDoc == null
          ? await firebaseFirestore
              .collection('products')
              .orderBy('timestamp')
              .where(
                'keywords',
                arrayContains: productName,
              )
              .limit(7)
              .get()
          : await firebaseFirestore
              .collection('products')
              .orderBy('timestamp')
              .where(
                'keywords',
                arrayContains: productName,
              )
              .startAfterDocument(lastDoc!)
              .limit(4)
              .get();

      lastDoc = refreshedClass.docs.last;

      if (refreshedClass.docs.length <= 7) {}
      // log('document: ${refreshedClass.docs.toString()}');

      list.addAll(
        refreshedClass.docs.map((e) {
          return ProductModel.fromFireStore(e);
        }),
      );
      return right(list);
    } catch (e) {
      log('PRODUCT SEARCH FAILURE : $e');
      return left(const MainFailure.noElemet(errorMsg: ''));
    }
  }

  void clearDoc() {
    lastDoc = null;
  }
}

// abstract class FirestoreConvertible<T> {
//   factory FirestoreConvertible.fromFirebase(
//     QueryDocumentSnapshot<Map<String, dynamic>> doc,
//   ) {
//     // This factory constructor should be implemented in the subclasses (e.g., ProductModel)
//     throw UnimplementedError(
//         'Implement this factory constructor in the subclasses.');
//   }
// }



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:injectable/injectable.dart';

// @lazySingleton
// class SearchRepo<T extends FirestoreConvertible<T>> {
//   final FirebaseFirestore firebaseFirestore;
//   SearchRepo({
//     required this.firebaseFirestore,
//   });

//   List<T> list = [];

//   QueryDocumentSnapshot<Map<String, dynamic>>? lastDoc;

//   Future<void> searchProduct({
//     required String productName,
//     required String collectionName,
//   }) async {
//     QuerySnapshot<Map<String, dynamic>> refreshedClass;

//     try {
//       refreshedClass = lastDoc == null
//           ? await firebaseFirestore
//               .collection(collectionName)
//               .orderBy('timestamp')
//               .where(
//                 'keywords',
//                 arrayContains: productName,
//               )
//               .limit(7)
//               .get()
//           : await firebaseFirestore
//               .collection(collectionName)
//               .orderBy('timestamp')
//               .where(
//                 'keywords',
//                 arrayContains: productName,
//               )
//               .startAfterDocument(lastDoc!)
//               .limit(4)
//               .get();

//       lastDoc = refreshedClass.docs.last;

//       if (refreshedClass.docs.length <= 7) {}
//       // log('document: ${refreshedClass.docs.toString()}');

//       list.addAll(
//         refreshedClass.docs.map((e) {
//           return T;
//         }),
//       );
//     } catch (e) {}
//   }
// }

// abstract class FirestoreConvertible<T> {
//   T fromFireStore(QueryDocumentSnapshot<Map<String, dynamic>> doc);
// }

