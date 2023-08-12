// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:mytune/features/authentication/provider/login_provider.dart';
import 'package:mytune/features/comment/model/comments_model.dart';
import 'package:provider/provider.dart';

import 'package:mytune/features/comment/provider/comment_provider.dart';
import 'package:mytune/features/comment/screens/widgets/custom_comment_bubble.dart';
import 'package:mytune/features/sheared/custom_catched_network_image.dart';
import 'package:mytune/general/serveices/constants.dart';

import 'widgets/comment_list_tile_item.dart';
import 'widgets/comment_text_box.dart';

class CommentItem extends StatefulWidget {
  const CommentItem({
    Key? key,
    required this.size,
    required this.videoId,
  }) : super(key: key);

  final Size size;
  final String videoId;

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    controller.addListener(() {
      if (controller.position.atEdge) {
        if (controller.position.pixels != 0) {
          if (Provider.of<CommentProvider>(context, listen: false)
                      .isFirebaseLoading ==
                  false &&
              Provider.of<CommentProvider>(context, listen: false).noMoreDta ==
                  false) {
            Provider.of<CommentProvider>(context, listen: false)
                .getAllCommentsByLimite(videoId: widget.videoId);
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<CommentProvider, LoginProvider>(
      builder: (context, state, state1, _) => Container(
        color: Colors.white,
        height: widget.size.height * 0.6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Divider(
              thickness: 0.8,
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  state.isFirebaseLoading == false
                      ? SliverList.builder(
                          itemCount: state.comments.length,
                          itemBuilder: ((context, index) {
                            final Comment comment = state.comments[index];
                            return CommentListTile(
                                size: widget.size, comment: comment);
                          }),
                        )
                      : SliverFillRemaining(
                          child: Center(
                            child: state.comments.isNotEmpty
                                ? const CupertinoActivityIndicator()
                                : Text('Empty',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                          ),
                        ),
                  state.isFirebaseLoading == true && state.comments.length > 10
                      ? const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CupertinoActivityIndicator(),
                          ),
                        )
                      : const SliverToBoxAdapter(),
                ],
              ),
            ),
            const Divider(
              thickness: 0.8,
            ),
            Container(
              height: 60,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 45,
                    width: 45,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: state1.isLoggdIn == true &&
                              state1.appUser != null &&
                              state1.appUser!.imageUrl != null &&
                              state1.appUser!.imageUrl!.isNotEmpty
                          ? CustomCachedNetworkImage(
                              url: state1.appUser!.imageUrl!,
                            )
                          : Container(
                              color: Colors.black.withOpacity(0.2),
                              child: const Icon(
                                IconlyLight.profile,
                                color: Color.fromARGB(255, 107, 122, 134),
                              ),
                            ),
                    ),
                  ),
                  kSizedBoxW5,
                  SizedBox(
                    height: 100,
                    width: widget.size.width - 80,
                    child: InkWell(
                      splashFactory: NoSplash.splashFactory,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        showModalBottomSheet(
                          // enableDrag: true,
                          backgroundColor: Colors.transparent,
                          shape: Border.all(style: BorderStyle.none),
                          isScrollControlled: true,

                          context: context,

                          builder: (ctx) => CommentTextBox(
                            size: widget.size,
                            videoId: widget.videoId,
                          ),
                        );
                      },
                      child: const ReceivedMessage(
                        message: 'Share Your Thoughts',
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
