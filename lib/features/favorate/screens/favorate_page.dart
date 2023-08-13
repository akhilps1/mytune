import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:mytune/features/authentication/provider/login_provider.dart';
import 'package:mytune/features/favorate/provider/favorate_provider.dart';
import 'package:mytune/features/home/provider/local_db_data_provider.dart';
import 'package:mytune/features/product_details/provider/product_details_provider.dart';
import 'package:mytune/features/product_details/screens/product_details_page.dart';
import 'package:provider/provider.dart';

import '../../sheared/custom_catched_network_image.dart';

class FavoratePage extends StatefulWidget {
  const FavoratePage({super.key});

  @override
  State<FavoratePage> createState() => _FavoratePageState();
}

class _FavoratePageState extends State<FavoratePage> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (Provider.of<LoginProvider>(context, listen: false).isLoggdIn ==
              true &&
          Provider.of<FavorateProvider>(context, listen: false)
              .savedVideos
              .isEmpty &&
          Provider.of<FavorateProvider>(context, listen: false).noMoreData ==
              false) {
        Provider.of<FavorateProvider>(
          context,
          listen: false,
        ).getSavedVideos(
          videoIds: Provider.of<LoginProvider>(context, listen: false)
                  .appUser!
                  .favoriteVideos ??
              [],
        );
      }
    });
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          if (Provider.of<FavorateProvider>(context, listen: false)
                      .isFirebaseLoading ==
                  false &&
              Provider.of<LoginProvider>(context, listen: false).isLoggdIn ==
                  true &&
              Provider.of<FavorateProvider>(context, listen: false)
                      .noMoreData ==
                  false) {
            Provider.of<FavorateProvider>(context, listen: false)
                .getSavedVideos(
              videoIds: Provider.of<LoginProvider>(context, listen: false)
                      .appUser!
                      .favoriteVideos ??
                  [],
            );
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer3<FavorateProvider, LoginProvider, LocalDbDataProvider>(
      builder: (context, state, state1, state2, _) => Container(
        color: Colors.grey[200],
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverAppBar(
              title: const Text('Favorate'),
              pinned: true,
              elevation: 2,
              forceElevated: true,
              shadowColor: Colors.black.withOpacity(0.3),
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
            ),
            state.savedVideos.isNotEmpty && state.isFirebaseLoading == false
                ? SliverPadding(
                    padding: const EdgeInsets.all(12),
                    sliver: SliverList.separated(
                      itemCount: state.savedVideos.length,
                      itemBuilder: (context, index) {
                        final data = state.savedVideos[index];
                        return InkWell(
                          onTap: () async {
                            if (state1.isLoggdIn) {
                              if (state2.likedVideos.contains(data.id) ==
                                  true) {
                                // print('111');
                              } else {
                                await state2.checkLiked(
                                  product: data,
                                  userId: state1.appUser!.id!,
                                );
                                // print('222');
                              }
                              // ignore: use_build_context_synchronously
                              Provider.of<ProductDetailsProvider>(
                                context,
                                listen: false,
                              ).clear();
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailsPage(
                                    product: data,
                                    title: null,
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey[200],
                            ),
                            child: Stack(children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: CustomCachedNetworkImage(
                                    url: data.imageUrl),
                              ),
                              const Align(
                                alignment: Alignment.center,
                                child: IconButton(
                                    padding: EdgeInsets.zero,
                                    style: ButtonStyle(
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Colors.white)),
                                    onPressed: null,
                                    icon: Icon(
                                      Icons.play_circle_fill,
                                      size: 40,
                                      color: Colors.black87,
                                    )),
                              ),
                              Positioned(
                                bottom: 5,
                                left: 5,
                                right: 5,
                                child: Container(
                                  height: 45,
                                  width: size.width - 30,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        data.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                            ),
                                        maxLines: 2,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                    ),
                  )
                : state.savedVideos.isEmpty && state.isFirebaseLoading == false
                    ? SliverFillRemaining(
                        child: Center(
                          child: Lottie.asset(
                            'assets/lottie/empty_hart.json',
                            height: 200,
                            width: 200,
                            repeat: false,
                          ),
                        ),
                      )
                    : const SliverFillRemaining(
                        child: Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
