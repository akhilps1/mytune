// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

import 'package:mytune/features/authentication/models/user_model.dart';
import 'package:mytune/general/failures/main_failure.dart';

@lazySingleton
class UserDetailsRepo {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;
  UserDetailsRepo({
    required this.firebaseFirestore,
    required this.firebaseStorage,
  });

  Future<Either<MainFailure, Unit>> updateUserDetails(
      {required AppUser user}) async {
    try {
      await firebaseFirestore.collection("users").doc(user.id).update({
        'userName': user.userName,
        'email': user.email,
        'age': user.age,
        'city': user.city,
        'favorateSinger': user.favorateSinger,
        'hobbies': user.hobbies,
        'imageUrl': user.imageUrl,
      });
      return right(unit);
    } catch (e) {
      return left(const MainFailure.serverFailure());
    }
  }

  Future<Either<MainFailure, String>> uploadImage({
    required Uint8List bytesImage,
  }) async {
    try {
      Reference storageRef = firebaseStorage
          .ref()
          .child('profile')
          .child('${Timestamp.now().microsecondsSinceEpoch}webp_image.jpeg');

      final value = await storageRef.putData(
        bytesImage,
        SettableMetadata(contentType: 'image/jpeg'),
      );
      final url = await value.ref.getDownloadURL();

      log(url);
      return right(url);
    } on FirebaseException catch (_) {
      return left(const MainFailure.serverFailure());
    }
  }
}
