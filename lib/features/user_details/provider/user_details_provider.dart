import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mytune/features/authentication/models/user_model.dart';
import 'package:mytune/features/authentication/provider/login_provider.dart';
import 'package:mytune/features/user_details/repository/user_details_repo.dart';
import 'package:mytune/general/di/injection.dart';
import 'package:mytune/general/serveices/custom_toast.dart';

@injectable
class UserDetailsProvider with ChangeNotifier {
  final UserDetailsRepo _userDetailsRepo = locater<UserDetailsRepo>();

  AppUser? appUser;
  bool isLoading = false;

  // void getUserDetails({required String userId}) {
  //   final data = _userDetailsRepo.getUserDetails(userId: userId);

  //   data.listen((userDoc) {
  //     appUser = AppUser.fromSnapshot(userDoc);
  //   });
  // }

  Future<String?> uploadImage({required Uint8List bytesImage}) async {
    String? url;
    final data = await _userDetailsRepo.uploadImage(bytesImage: bytesImage);

    data.fold(
      (l) => null,
      (r) => url = r,
    );
    return url;
  }

  Future<void> updateUserDetails({
    required String id,
    required String mobileNumber,
    required String name,
    required String email,
    required String age,
    required String city,
    String? hobbies,
    String? favorateSinger,
    String? imageUrl,
    String? skills,
  }) async {
    isLoading = true;
    notifyListeners();
    final hobbie = hobbies?.split(',');
    final skillList = skills?.split(',');
    final data = AppUser(
      id: id,
      userName: name,
      imageUrl: imageUrl ?? '',
      mobileNumber: mobileNumber,
      email: email,
      age: age,
      city: city,
      favorateSinger: favorateSinger ?? '',
      skills: skillList ?? [],
      notificationToken: '',
      hobbies: hobbie ?? [],
      keywords: [],
      followedCategory: [],
      likedVideos: [],
      timestamp: Timestamp.now(),
      favoriteVideos: [],
    );

    print(id);

    final failureOrSuccess =
        await _userDetailsRepo.updateUserDetails(user: data);

    failureOrSuccess.fold(
      (l) {
        CustomToast.errorToast('Details upload failed');
        isLoading = false;
        notifyListeners();
      },
      (r) async {
        CustomToast.successToast('Details upload success');

        isLoading = false;
        notifyListeners();
      },
    );
  }
}
