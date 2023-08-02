// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String userName;
  String imageUrl;
  final String mobileNumber;
  final String email;
  String age;
  String city;
  String favorateSinger;
  List skills;
  final String notificationToken;
  List hobbies;
  final List keywords;
  List followedCategory;
  List likedVideos;
  List favoriteVideos;

  Timestamp timestamp;
  AppUser({
    required this.userName,
    required this.imageUrl,
    required this.mobileNumber,
    required this.email,
    required this.age,
    required this.city,
    required this.favorateSinger,
    required this.skills,
    required this.notificationToken,
    required this.hobbies,
    required this.keywords,
    required this.followedCategory,
    required this.likedVideos,
    required this.timestamp,
    required this.favoriteVideos,
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
    };
  }

  factory AppUser.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snap) {
    final map = snap.data()!;
    return AppUser(
      userName: map['userName'] as String,
      imageUrl: map['imageUrl'] as String,
      mobileNumber: map['mobileNumber'] as String,
      email: map['email'] as String,
      age: map['age'] as String,
      city: map['city'] as String,
      favorateSinger: map['favorateSinger'] as String,
      skills: map['skills'] as List,
      hobbies: map['hobbies'] as List,
      timestamp: map['timestamp'] as Timestamp,
      keywords: map['keywords'] as List,
      notificationToken: map['notificationToken'] as String,
      followedCategory: map['followedCategory'] as List,
      likedVideos: map['likedVideos'] as List,
      favoriteVideos: map['favoriteVideos'] as List,
    );
  }

  @override
  String toString() {
    return '''AppUser(
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
