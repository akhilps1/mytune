// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:mytune/general/serveices/get_object_id.dart';

class CategoryModel implements ObjectWithId {
  final String? id;

  bool visibility;

  String categoryName;

  String imageUrl;

  int followers;

  final Timestamp timestamp;

  final List keywords;

  bool isCraft;

  bool isTopTen;

  int? totalVideos;
  String? proffession;

  int? totalLikes;
  CategoryModel({
    required this.visibility,
    required this.categoryName,
    required this.imageUrl,
    required this.timestamp,
    required this.keywords,
    required this.followers,
    required this.isTopTen,
    this.proffession,
    this.totalVideos,
    this.id,
    this.isCraft = true,
    this.totalLikes,
  });

  void changeCraftOrCrew() {
    isCraft = !isCraft;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'visibility': visibility,
      'categoryName': categoryName,
      'imageUrl': imageUrl,
      'timestamp': timestamp,
      'keywords': keywords,
      'followers': followers,
      'isCraft': isCraft,
      'isTopTen': isTopTen,
      'totalVideos': totalVideos,
      'totalLikes': totalLikes,
      'proffession': proffession,
    };
  }

  factory CategoryModel.fromFireStore(
      QueryDocumentSnapshot<Map<String, dynamic>> data) {
    Map<String, dynamic> map = data.data();
    return CategoryModel(
      id: data.id,
      followers: map['followers'] as int,
      visibility: map['visibility'] as bool,
      categoryName: map['categoryName'] as String,
      imageUrl: map['imageUrl'] as String,
      timestamp: map['timestamp'] as Timestamp,
      keywords: map['keywords'] as List,
      isTopTen: map['isTopTen'] as bool,
      totalVideos: map['totalVideos'],
      totalLikes: map['totalLikes'],
      proffession: map['proffession'],
    );
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      followers: map['followers'] as int,
      visibility: map['visibility'] as bool,
      categoryName: map['categoryName'] as String,
      imageUrl: map['imageUrl'] as String,
      timestamp: map['timestamp'] as Timestamp,
      keywords: map['keywords'] as List,
      isCraft: map['isCraft'] as bool,
      isTopTen: map['isTopTen'] as bool,
      totalVideos: map['totalVideos'],
      totalLikes: map['totalLikes'],
      proffession: map['proffession'],
    );
  }
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(covariant CategoryModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.visibility == visibility &&
        other.categoryName == categoryName &&
        other.imageUrl == imageUrl &&
        other.followers == followers &&
        other.timestamp == timestamp &&
        listEquals(other.keywords, keywords);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        visibility.hashCode ^
        categoryName.hashCode ^
        imageUrl.hashCode ^
        followers.hashCode ^
        timestamp.hashCode ^
        keywords.hashCode;
  }

  CategoryModel copyWith({
    String? id,
    bool? visibility,
    String? categoryName,
    String? imageUrl,
    int? followers,
    Timestamp? timestamp,
    List? keywords,
    bool? isCraft,
    bool? isTopTen,
    int? totalVideos,
    String? proffession,
    int? totalLikes,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      visibility: visibility ?? this.visibility,
      categoryName: categoryName ?? this.categoryName,
      imageUrl: imageUrl ?? this.imageUrl,
      followers: followers ?? this.followers,
      timestamp: timestamp ?? this.timestamp,
      keywords: keywords ?? this.keywords,
      isCraft: isCraft ?? this.isCraft,
      isTopTen: isTopTen ?? this.isTopTen,
      totalVideos: totalVideos ?? this.totalVideos,
      proffession: proffession ?? this.proffession,
      totalLikes: totalLikes ?? this.totalLikes,
    );
  }

  @override
  String toString() {
    return 'CategoryModel(id: $id, visibility: $visibility, categoryName: $categoryName, imageUrl: $imageUrl, followers: $followers, timestamp: $timestamp, keywords: $keywords, isCraft: $isCraft, isTopTen: $isTopTen, totalVideos: $totalVideos, proffession: $proffession, totalLikes: $totalLikes)';
  }

  @override
  String getId() {
    return id!;
  }

  // @override
  // String getId() {
  //   return id!;
  // }
}
