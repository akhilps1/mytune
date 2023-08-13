// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String? id;
  final String? userName;
  String? imageUrl;
  final String? mobileNumber;
  final String? email;
  String? age;
  String? city;
  String? favorateSinger;
  List? skills;
  final String? notificationToken;
  List? hobbies;
  final List? keywords;
  List? followedCategory;
  List? likedVideos;
  List? favoriteVideos;

  Timestamp? timestamp;
  AppUser({
    this.userName,
    this.imageUrl,
    this.mobileNumber,
    this.email,
    this.age,
    this.city,
    this.favorateSinger,
    this.skills,
    this.notificationToken,
    this.hobbies,
    this.keywords,
    this.followedCategory,
    this.likedVideos,
    this.timestamp,
    this.favoriteVideos,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'imageUrl': imageUrl,
      'mobileNumber': mobileNumber,
      'email': email,
      'age': age,
      'city': city,
      'favorateSinger': favorateSinger,
      'skills': skills,
      'hobbies': hobbies,
      'timestamp': timestamp,
      'keywords': keywords,
      'notificationToken': notificationToken,
      'likedVideos': likedVideos,
      'followedCategory': followedCategory,
      'favoriteVideos': favoriteVideos,
      'id': id,
    };
  }

  factory AppUser.fromSnapshot(DocumentSnapshot<Map<String, dynamic>>? snap) {
    final map = snap?.data();
    return AppUser(
      id: snap?.id,
      userName: map?['userName'],
      imageUrl: map?['imageUrl'],
      mobileNumber: map?['mobileNumber'],
      email: map?['email'],
      age: map?['age'],
      city: map?['city'],
      favorateSinger: map?['favorateSinger'],
      skills: map?['skills'],
      hobbies: map?['hobbies'],
      timestamp: map?['timestamp'],
      keywords: map?['keywords'],
      notificationToken: map?['notificationToken'],
      followedCategory: map?['followedCategory'],
      likedVideos: map?['likedVideos'],
      favoriteVideos: map?['favoriteVideos'],
    );
  }

  @override
  String toString() {
    return '''AppUser(
      id: $id,
      userName: $userName, 
      imageUrl: $imageUrl, 
      mobileNumber: $mobileNumber,
      email: $email, 
      age: $age, 
      city: $city, 
      favorateSinger: $favorateSinger, 
      skills: $skills, 
      notificationToken: $notificationToken, 
      hobbies: $hobbies, 
      keywords: $keywords, 
      timestamp: $timestamp
    )''';
  }

  AppUser copyWith({
    String? id,
    String? userName,
    String? imageUrl,
    String? mobileNumber,
    String? email,
    String? age,
    String? city,
    String? favorateSinger,
    List? skills,
    String? notificationToken,
    List? hobbies,
    List? keywords,
    List? followedCategory,
    List? likedVideos,
    List? favoriteVideos,
    Timestamp? timestamp,
  }) {
    return AppUser(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      imageUrl: imageUrl ?? this.imageUrl,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      email: email ?? this.email,
      age: age ?? this.age,
      city: city ?? this.city,
      favorateSinger: favorateSinger ?? this.favorateSinger,
      skills: skills ?? this.skills,
      notificationToken: notificationToken ?? this.notificationToken,
      hobbies: hobbies ?? this.hobbies,
      keywords: keywords ?? this.keywords,
      followedCategory: followedCategory ?? this.followedCategory,
      likedVideos: likedVideos ?? this.likedVideos,
      favoriteVideos: favoriteVideos ?? this.favoriteVideos,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
