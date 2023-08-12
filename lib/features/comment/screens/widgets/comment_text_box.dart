// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mytune/features/authentication/screens/login_screen.dart';
import 'package:provider/provider.dart';

import 'package:mytune/features/authentication/provider/login_provider.dart';
import 'package:mytune/features/comment/model/comments_model.dart';
import 'package:mytune/features/comment/provider/comment_provider.dart';
import 'package:mytune/general/serveices/custom_toast.dart';

class CommentTextBox extends StatelessWidget {
  const CommentTextBox({
    Key? key,
    required this.size,
    required this.videoId,
  }) : super(key: key);

  final Size size;
  final String videoId;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Consumer2<LoginProvider, CommentProvider>(
      builder: (context, state, state1, _) => Container(
        color: Colors.white,
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 15, top: 8, bottom: 8),
                child: Container(
                    height: 45,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    width: size.width - 100,
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(20)),
                    child: TextField(
                      controller: controller,
                      autofocus: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    )),
              ),
              IconButton(
                  onPressed: () async {
                    if (controller.text.isEmpty) {
                      CustomToast.errorToast('Write somthing to post');
                      return;
                    }
                    if (state.isLoggdIn == true && state.appUser != null) {
                      final comment = Comment(
                        commentText: controller.text,
                        createAt: Timestamp.now(),
                        userName: state.appUser!.userName ?? 'user',
                        profilePicture: state.appUser!.imageUrl ?? '',
                      );
                      await state1
                          .postComment(
                        comment: comment,
                        videoId: videoId,
                        userId: state.appUser!.id!,
                      )
                          .then((value) {
                        Navigator.pop(context);
                      });
                    } else {
                      showModalBottomSheet(
                        // enableDrag: true,

                        isScrollControlled: true,
                        context: context,
                        builder: (ctx) => Padding(
                          padding: MediaQuery.of(ctx).viewInsets,
                          child: LoginScreen(
                            ctx: ctx,
                          ),
                        ),
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.grey,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
