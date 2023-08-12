import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:mytune/features/comment/model/comments_model.dart';
import 'package:mytune/features/comment/repository/comment_repo.dart';
import 'package:mytune/general/di/injection.dart';
import 'package:mytune/general/failures/main_failure.dart';
import 'package:mytune/general/serveices/custom_toast.dart';

@injectable
class CommentProvider with ChangeNotifier {
  final CommentRepo _commentRepo = locater<CommentRepo>();

  bool isFirebaseLoading = false;
  bool isLoading = true;
  bool noMoreDta = false;

  final List<Comment> comments = [];
  final List<Comment> userComments = [];

  Future<void> postComment({
    required Comment comment,
    required String videoId,
    required String userId,
  }) async {
    Either<MainFailure, Unit> failureOrSuuccess =
        await _commentRepo.postComment(
      comment: comment,
      videoId: videoId,
    );
    failureOrSuuccess.fold(
      (l) {
        CustomToast.errorToast('faild');
      },
      (r) {
        comments.insert(0, comment);

        CustomToast.successToast('success');
        notifyListeners();
      },
    );
  }

  Future<void> getAllCommentsByLimite({required String videoId}) async {
    // log('getAllCommentsByLimite called');

    isFirebaseLoading = true;
    notifyListeners();
    // await Future.delayed(Duration(seconds: 3));
    Either<MainFailure, List<Comment>> failureOrSuuccess =
        await _commentRepo.getCommentsByLimit(videoId: videoId);

    failureOrSuuccess.fold(
      (failure) {
        isFirebaseLoading = false;
        noMoreDta = true;
        notifyListeners();
      },
      (success) {
        log(success.toString());
        isFirebaseLoading = false;
        comments.addAll(success);
        notifyListeners();
      },
    );
  }

  void clearDoc() {
    _commentRepo.clearDoc();
    comments.clear();
  }
}
