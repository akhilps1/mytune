// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'package:mytune/features/authentication/repository/firebase_login_serveices.dart';
import 'package:mytune/general/failures/main_failure.dart';
import 'package:mytune/general/serveices/custom_toast.dart';

@injectable
class LoginProvider with ChangeNotifier {
  final FirebaseLoginServeices firebaseLoginServeices;
  final FirebaseAuth firebaseAuth;

  LoginProvider({
    required this.firebaseLoginServeices,
    required this.firebaseAuth,
  });

  bool otpSent = false;
  bool isLoading = false;
  String id = '';
  String? phone;

  int? token;

  Future<void> sendOtpClicked({required String phoneNumber}) async {
    isLoading = true;
    notifyListeners();
    phone = phoneNumber;

    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          isLoading = false;
          notifyListeners();
          // print('FIREBASE LOGIN ERROR: ${e.toString()} ');
          CustomToast.errorToast('Otp send faild');
        },
        codeSent: (String verificationId, int? resendToken) {
          token = resendToken;
          id = verificationId;
          otpSent = true;
          isLoading = false;
          notifyListeners();
          CustomToast.successToast('Otp send successfully');
          // print('VERIFICATION ID: $verificationId');
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }

    log('sendOtpClicked: ------------------> $phoneNumber');
  }

  Future<void> veryfyOtpClicked({required String otp}) async {
    await firebaseLoginServeices.verifyOtp(
      otp: otp,
      id: id,
      phone: phone!,
    );
  }
}
