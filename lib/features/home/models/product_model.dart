// ignore_for_file: public_member_api_docs, sort_constructors_first

// import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:mytune/general/serveices/get_object_id.dart';

import 'category_model.dart';

class ProductModel implements ObjectWithId {
  final String? id;

  final String categoryId;

  String title;

  String description;

  String imageUrl;

  int likes;

  int views;

  bool isTopThree;

  bool visibility;

  bool isTrending;

  Map<String, Map<String, dynamic>> craftAndCrew;

  List<CategoryModel> categories;
  List<CategoryModel>? castOrCrew;

  List keywords;

  final Timestamp timestamp;

  bool isTodayRelease;

  String? trendingImage;

  String videoUrl;

  bool isLiked = false;

  ProductModel({
    this.id,
    this.categories = const [],
    required this.categoryId,
    required this.isTodayRelease,
    required this.isTopThree,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.likes,
    required this.views,
    required this.craftAndCrew,
    required this.visibility,
    required this.keywords,
    required this.timestamp,
    required this.isTrending,
    required this.videoUrl,
    this.trendingImage,
    this.castOrCrew,
  });

  set setCategores(List<CategoryModel> list) {
    categories = list;
  }

  @override
  String getId() => id!;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoryId': categoryId,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'likes': likes,
      'views': views,
      'craftAndCrew': craftAndCrew,
      'visibility': visibility,
      'keywords': keywords,
      'timestamp': timestamp,
      'isTodayRelease': isTodayRelease,
      'isTopThree': isTopThree,
      'isTrending': isTrending,
      'trendingImage': trendingImage,
    };
  }

  factory ProductModel.fromFireStore(
      QueryDocumentSnapshot<Map<String, dynamic>> datas) {
    Map<String, dynamic> data = datas.data();
    final List<CategoryModel> list = [];
    // convert map to category model
    data['craftAndCrew'].forEach((key, value) {
      list.add(
        CategoryModel.fromMap(
          value,
        ).copyWith(id: key),
      );
    });

    return ProductModel(
      id: datas.id,
      categoryId: data['categoryId'] as String,
      title: data['title'] as String,
      visibility: data['visibility'] as bool,
      description: data['description'] as String,
      imageUrl: data['imageUrl'] as String,
      likes: data['likes'] as int,
      views: data['views'] as int,
      craftAndCrew: Map.from(
        data['craftAndCrew'],
      ),
      keywords: data['keywords'] as List,
      timestamp: data['timestamp'] as Timestamp,
      categories: list,
      isTodayRelease: data['isTodayRelease'] as bool,
      isTopThree: data['isTopThree'] as bool,
      isTrending: data['isTrending'] as bool,
      trendingImage: data['trendingImage'] as String?,
      videoUrl: data['videoUrl'] as String,
    );
  }

  factory ProductModel.fromMap(Map<String, dynamic> data) {
    final List<CategoryModel> list = [];
    // convert map to category model
    data['craftAndCrew'].forEach((key, value) {
      list.add(
        CategoryModel.fromMap(
          value,
        ).copyWith(
          id: key,
        ),
      );
    });

    return ProductModel(
      categoryId: data['categoryId'] as String,
      title: data['title'] as String,
      visibility: data['visibility'] as bool,
      description: data['description'] as String,
      imageUrl: data['imageUrl'] as String,
      likes: data['likes'] as int,
      views: data['views'] as int,
      craftAndCrew: Map.from(
        data['craftAndCrew'],
      ),
      keywords: data['keywords'] as List,
      timestamp: data['timestamp'] as Timestamp,
      categories: list,
      isTodayRelease: data['isTodayRelease'] as bool,
      isTopThree: data['isTopThree'] as bool,
      isTrending: data['isTrending'] as bool,
      trendingImage: data['trendingImage'] as String?,
      videoUrl: data['videoUrl'] as String,
    );
  }

  void checkLiked({
    required List<String> videoIds,
  }) {
    isLiked = videoIds.contains(id);
  }

  @override
  String toString() {
    return 'ProductModel(id: $id, title: $title, description: $description, imageUrl: $imageUrl, categoryId: $categoryId, likes: $likes, views: $views, isTodayRelease: $isTodayRelease, isTopThree: $isTopThree, visibility: $visibility, isTrending: $isTrending, craftAndCrew: $craftAndCrew, categories: $categories, keywords: $keywords, timestamp: $timestamp)';
  }

  ProductModel copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? categoryId,
    int? likes,
    int? views,
    bool? isTopThree,
    bool? visibility,
    bool? isTrending,
    Map<String, Map<String, dynamic>>? craftAndCrew,
    List<CategoryModel>? categories,
    List? keywords,
    Timestamp? timestamp,
    bool? isTodayRelease,
    String? trendingImage,
    String? videoUrl,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      categoryId: categoryId ?? this.categoryId,
      likes: likes ?? this.likes,
      views: views ?? this.views,
      isTopThree: isTopThree ?? this.isTopThree,
      visibility: visibility ?? this.visibility,
      isTrending: isTrending ?? this.isTrending,
      craftAndCrew: craftAndCrew ?? this.craftAndCrew,
      categories: categories ?? this.categories,
      keywords: keywords ?? this.keywords,
      timestamp: timestamp ?? this.timestamp,
      isTodayRelease: isTodayRelease ?? this.isTodayRelease,
      trendingImage: trendingImage ?? this.trendingImage,
      videoUrl: videoUrl ?? this.videoUrl,
    );
  }
}
