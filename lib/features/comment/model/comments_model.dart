// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String commentText;
  final Timestamp createAt;

  String? id;

  String userName;
  String profilePicture;

  Comment({
    required this.commentText,
    required this.createAt,
    required this.userName,
    required this.profilePicture,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'commentText': commentText,
      'createAt': createAt,
      'userName': userName,
      'profilePicture': profilePicture,
    };
  }

  factory Comment.fromMap(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> map = doc.data();
    return Comment(
      id: doc.id,
      commentText: map['commentText'] as String,
      createAt: map['createAt'],
      userName: map['userName'] as String,
      profilePicture: map['profilePicture'] as String,
    );
  }

  @override
  bool operator ==(covariant Comment other) {
    if (identical(this, other)) return true;

    return other.commentText == commentText &&
        other.createAt == createAt &&
        other.userName == userName &&
        other.profilePicture == profilePicture;
  }

  @override
  int get hashCode {
    return commentText.hashCode ^
        createAt.hashCode ^
        userName.hashCode ^
        profilePicture.hashCode;
  }

  Comment copyWith({
    String? commentText,
    Timestamp? createAt,
    String? id,
    String? userName,
    String? profilePicture,
  }) {
    return Comment(
      commentText: commentText ?? this.commentText,
      createAt: createAt ?? this.createAt,
      id: id ?? this.id,
      userName: userName ?? this.userName,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }

  @override
  String toString() {
    return 'Comment(commentText: $commentText, createAt: $createAt, userName: $userName, profilePicture: $profilePicture)';
  }
}
