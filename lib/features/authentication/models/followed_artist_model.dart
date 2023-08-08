// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class FollowedArtist {
  String? id;
  FollowedArtist({
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
    };
  }

  factory FollowedArtist.fromMap(
      QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> map = doc.data();
    return FollowedArtist(
      id: map['id'] != null ? map['id'] as String : null,
    );
  }

  FollowedArtist copyWith({
    String? id,
  }) {
    return FollowedArtist(
      id: id ?? this.id,
    );
  }
}
