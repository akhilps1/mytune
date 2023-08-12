// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:mytune/features/authentication/models/user_model.dart';

import 'package:mytune/features/authentication/repository/firebase_login_serveices.dart';
import 'package:mytune/general/failures/main_failure.dart';
import 'package:mytune/general/serveices/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../general/di/injection.dart';
import '../../user_details/screen/user_details_screen.dart';

@injectable
class LoginProvider with ChangeNotifier {
  final FirebaseLoginServeices firebaseLoginServeices =
      locater<FirebaseLoginServeices>();
  final FirebaseAuth firebaseAuth = locater<FirebaseAuth>();

  bool otpSent = false;
  bool isLoading = false;
  String id = '';
  String? phone;

  int? token;
  bool isLoggdIn = false;

  AppUser? appUser;
  User? user;

  Future<void> sendOtpClicked({required String phoneNumber}) async {
    isLoading = true;
    notifyListeners();
    phone = phoneNumber;
    log('sendOtpClicked: ------------------> $phoneNumber');

    try {
      await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          isLoading = false;
          notifyListeners();
          log('FIREBASE LOGIN ERROR: ${e.toString()} ');
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
      log(e.toString());
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> veryfyOtpClicked(
      {required String otp, required BuildContext context}) async {
    isLoading = true;
    notifyListeners();
    final falureOrSuccess = await firebaseLoginServeices.verifyOtp(
      otp: otp,
      id: id,
      phone: phone!,
    );
    falureOrSuccess.fold(
      (failure) {
        CustomToast.errorToast('Otp verification faild');
        isLoading = false;
        notifyListeners();
      },
      (phoneAuthCredential) async {
        final falureOrSuccess = await firebaseLoginServeices
            .loginWithCredential(phoneAuthCredential);

        falureOrSuccess.fold(
          (failure) {
            CustomToast.errorToast('Login faild');
            isLoading = false;

            notifyListeners();
          },
          (userCredential) async {
            appUser = await firebaseLoginServeices.createUser(
                userCredential: userCredential, phoneNo: phone!);
            isLoading = false;
            isLoggdIn = true;
            checkLoginStatus();

            getUserDetails();
            notifyListeners();
            CustomToast.successToast('Login successful');

            if (isLoggdIn == true &&
                appUser != null &&
                appUser!.userName == null) {
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
              Get.to(UserDetailsScreen(appUser: appUser!));
            } else {
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            }
          },
        );
      },
    );
  }

  User? checkLoginStatus() {
    User? data;
    final successOrFailure = firebaseLoginServeices.getSignedInUser();

    successOrFailure.fold(
      (l) {
        log(l.toString());
        isLoggdIn = false;
        user = null;
        notifyListeners();
      },
      (r) {
        log(r.toString());
        user = r;
        isLoggdIn = true;
        data = r;
        notifyListeners();
      },
    );
    return data;
  }

  Future<void> logOut() async {
    otpSent = false;
    phone = null;
    await firebaseLoginServeices.logout();
    checkLoginStatus();
    notifyListeners();
  }

  void getUserDetails([BuildContext? context]) {
    final data = firebaseLoginServeices.getUserDetails(userId: user!.uid);

    data?.listen((event) {
      appUser = AppUser.fromSnapshot(event);

      notifyListeners();
    });
  }

  Future<void> deleteAccount() async {
    final String? userId = firebaseAuth.currentUser?.uid;

    if (userId != null) {
      final successorFailure =
          await firebaseLoginServeices.deleteAccount(userId: userId);
      successorFailure.fold(
        (l) {},
        (r) {
          logOut();
          CustomToast.successToast('Account deleted');
        },
      );
    } else {
      CustomToast.errorToast('Please Create a account first');
    }
  }
}
