// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mytune/features/comment/model/comments_model.dart';
import 'package:mytune/features/home/models/product_model.dart';
import 'package:mytune/general/failures/main_failure.dart';
import 'package:uuid/uuid.dart';

@lazySingleton
class CommentRepo {
  final FirebaseFirestore firebaseFirestore;
  QueryDocumentSnapshot<Map<String, dynamic>>? lastDoc;
  CommentRepo({
    required this.firebaseFirestore,
  });

  Future<Either<MainFailure, Unit>> postComment(
      {required Comment comment, required String videoId}) async {
    try {
      await firebaseFirestore
          .collection('products')
          .doc(videoId)
          .collection('comments')
          .add(
            comment.toMap(),
          );

      return right(unit);
    } catch (e) {
      return left(const MainFailure.serverFailure());
    }
  }

  // Future<Either<MainFailure, Unit>> getComment(
  //     {required String userId, required String videoId}) async {
  //   log('getComment called');
  //   DocumentSnapshot<Map<String, dynamic>> data;
  //   List<Comment> comments = [];
  //   try {
  //     data = await firebaseFirestore
  //         .collection('products')
  //         .doc(videoId)
  //         .collection('comments')
  //         .doc(userId)
  //         .get();
  //     log(data.data().toString());

  //     return right(unit);
  //   } catch (e) {
  //     return left(const MainFailure.noElemet(errorMsg: ''));
  //   }
  // }

  Future<Either<MainFailure, List<Comment>>> getCommentsByLimit(
      {required String videoId}) async {
    log('getCommentsByLimit called');
    List<Comment> comments = [];
    lastDoc = null;
    QuerySnapshot<Map<String, dynamic>> refreshedClass;
    try {
      refreshedClass = lastDoc == null
          ? await firebaseFirestore
              .collection('products')
              .doc(videoId)
              .collection('comments')
              .orderBy('createAt', descending: true)
              .limit(10)
              .get()
          : await firebaseFirestore
              .collection('products')
              .doc(videoId)
              .collection('comments')
              .orderBy('createAt', descending: true)
              .startAfterDocument(lastDoc!)
              .limit(6)
              .get();

      log(comments.toString());
      if (refreshedClass.docs.isNotEmpty) {
        lastDoc = refreshedClass.docs.last;
      } else {
        return left(const MainFailure.noElemet(errorMsg: ''));
      }

      comments.addAll(
        refreshedClass.docs.map(
          (e) => Comment.fromMap(
            e,
          ),
        ),
      );
      return right(comments);
      // log(users.length.toString());
    } catch (e) {
      log('getAllComments error ${e.toString()}');
      return left(const MainFailure.noElemet(errorMsg: ''));
    }
  }

  void clearDoc() {
    lastDoc = null;
  }
}
