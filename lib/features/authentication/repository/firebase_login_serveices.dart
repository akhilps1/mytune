// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:mytune/features/authentication/models/user_model.dart';
import 'package:mytune/general/failures/main_failure.dart';
import 'package:mytune/general/serveices/key_words_generater.dart';

@lazySingleton
class FirebaseLoginServeices {
  FirebaseLoginServeices({
    required this.firebaseFirestore,
    required this.firebaseMessaging,
    required this.firebaseAuth,
  });

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseMessaging firebaseMessaging;

  Future<Either<MainFailure, PhoneAuthCredential>> verifyOtp({
    required String otp,
    required String id,
    required String phone,
  }) async {
    // print('VERIFICATION ID: $id');
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: id,
        smsCode: otp,
      );
      return right(credential);
    } catch (e) {
      return left(const MainFailure.otpVerificationFaild());
    }
  }

  Future<Either<MainFailure, UserCredential>> loginWithCredential(
      PhoneAuthCredential credential) async {
    try {
      final userCredential =
          await firebaseAuth.signInWithCredential(credential);
      return right(userCredential);
    } catch (e) {
      log('OTP VERIFICATION ERROR: $e');
      return left(const MainFailure.logedInFailed());
    }
  }

  Future<AppUser> createUser(
      {required UserCredential userCredential, required String phoneNo}) async {
    late DocumentSnapshot<Map<String, dynamic>> userdetails;
    String? token;

    try {
      token = await firebaseMessaging.getToken();
      await firebaseMessaging.subscribeToTopic('admin');

      userdetails = await firebaseFirestore
          .collection("users")
          .doc(userCredential.user!.uid)
          .get();
    } catch (e) {
      log(e.toString());
    }

    if (userdetails.exists) {
      await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser?.uid)
          .update(
        {'notificationToken': token},
      );

      print(userCredential.toString());

      return AppUser.fromSnapshot(userdetails);
    } else {
      final user = AppUser(
        userName: '',
        notificationToken: token!,
        imageUrl: '',
        mobileNumber: phoneNo,
        email: '',
        age: '',
        city: '',
        skills: [],
        hobbies: [],
        favorateSinger: '',
        timestamp: Timestamp.now(),
        keywords: getKeywords(
          phoneNo.replaceAll('+', ''),
        ),
        followedCategory: [],
        likedVideos: [],
        favoriteVideos: [],
      );

      await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser?.uid)
          .set(
            user.toMap(),
          );
      // print('TOKEN: $token');

      return user.copyWith(
          mobileNumber: phoneNo, id: firebaseAuth.currentUser?.uid);
    }
  }

  Future<void> onResendOtp({required int resendToken}) async {
    await firebaseAuth.verifyPhoneNumber(
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      forceResendingToken: resendToken,
    );
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  Either<MainFailure, User> getSignedInUser() {
    final User? user = firebaseAuth.currentUser;

    if (user == null) {
      return left(const MainFailure.userNotSignedIn());
    }
    return right(user);
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserDetails(
      {required String userId}) {
    final data = firebaseFirestore.collection('users').doc(userId).snapshots();

    return data;
  }

  Future<Either<MainFailure, Unit>> deleteAccount(
      {required String userId}) async {
    try {
      await firebaseFirestore.collection('useers').doc(userId).delete();
      return right(unit);
    } catch (e) {
      return left(const MainFailure.serverFailure());
    }
  }
}
