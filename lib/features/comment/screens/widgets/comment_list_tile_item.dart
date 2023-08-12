// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import 'package:mytune/features/comment/model/comments_model.dart';
import 'package:mytune/features/sheared/custom_catched_network_image.dart';
import 'package:mytune/general/serveices/constants.dart';

class CommentListTile extends StatelessWidget {
  const CommentListTile({
    Key? key,
    required this.size,
    required this.comment,
  }) : super(key: key);

  final Size size;
  final Comment comment;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 45,
                width: 45,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10),
                  ),
                  child: comment.profilePicture.isNotEmpty
                      ? CustomCachedNetworkImage(
                          url: comment.profilePicture,
                        )
                      : Container(
                          color: Colors.black.withOpacity(0.2),
                          child: const Icon(
                            IconlyLight.profile,
                            color: Color.fromARGB(255, 127, 153, 174),
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment.userName,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                ),
                kSizedBoxH5,
                SizedBox(
                  width: size.width - 100,
                  child: ExpandableText(
                    comment.commentText,
                    expandText: 'See more',
                    collapseText: 'Hide',
                    textAlign: TextAlign.justify,
                    maxLines: 3,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                        ),
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
