// import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class LikedVideo {
  String? id;
  LikedVideo({
    this.id,
  });

  LikedVideo copyWith({
    String? id,
  }) {
    return LikedVideo(
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
    };
  }

  factory LikedVideo.fromMap(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> map = doc.data();
    return LikedVideo(
      id: map['id'] != null ? map['id'] as String : null,
    );
  }
}
