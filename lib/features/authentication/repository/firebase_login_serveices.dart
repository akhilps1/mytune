// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:mytune/features/authentication/models/user_model.dart';
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

  Future<void> verifyOtp({
    required String otp,
    required String id,
    required String phone,
  }) async {
    print('VERIFICATION ID: $id');
    final PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: id,
      smsCode: otp,
    );
    await _loginWithCredential(credential, phone);
  }

  Future<void> _loginWithCredential(
      PhoneAuthCredential credential, String phoneNo) async {
    late DocumentSnapshot<Map<String, dynamic>> userdetails;

    try {
      await firebaseAuth.signInWithCredential(credential).then((user) async {
        userdetails = await firebaseFirestore
            .collection("users")
            .doc(firebaseAuth.currentUser?.uid)
            .get();
        // subscribed

        //
        if (userdetails.exists) {
          print('USER EXISTS');
        } else {
          String? token = await firebaseMessaging.getToken();
          final user = AppUser(
            userName: '',
            notificationToken: token!,
            imageUrl: '',
            mobileNumber: '',
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
          );

          await firebaseMessaging.subscribeToTopic('admin');
          await firebaseFirestore
              .collection("users")
              .doc(firebaseAuth.currentUser?.uid)
              .set(
                user.toMap(),
              );
          print('TOKEN: $token');
        }
      });
    } catch (e) {
      log('OTP VERIFICATION ERROR: $e');
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
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}
