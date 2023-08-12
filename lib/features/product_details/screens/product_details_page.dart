// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:mytune/features/artist_details/provider/artist_details_provider.dart';
import 'package:mytune/features/authentication/screens/login_screen.dart';
import 'package:mytune/features/comment/provider/comment_provider.dart';
import 'package:mytune/features/comment/screens/commets.dart';
import 'package:mytune/features/favorate/provider/favorate_provider.dart';

import 'package:mytune/features/trending/provider/trending_page_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:mytune/features/authentication/provider/login_provider.dart';
import 'package:mytune/features/home/models/product_model.dart';
import 'package:mytune/features/home/provider/home_screen_provider.dart';
import 'package:mytune/features/comment/screens/widgets/custom_comment_bubble.dart';
import 'package:mytune/features/product_details/screens/widgets/custom_icon_button.dart';
import 'package:mytune/features/sheared/category_list_item.dart';
import 'package:mytune/features/sheared/custom_catched_network_image.dart';
import 'package:mytune/general/serveices/constants.dart';
import 'package:mytune/general/serveices/custom_toast.dart';
import 'package:mytune/general/serveices/dynamic_link/dynamic_link.dart';
import 'package:mytune/general/serveices/number_converter.dart';
import 'package:mytune/general/utils/enum/enums.dart';

import '../../home/provider/local_db_data_provider.dart';
import '../provider/product_details_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    Key? key,
    required this.product,
    this.title,
  }) : super(key: key);

  final ProductModel product;
  final String? title;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  bool expand = false;
  bool seeMoreClicked = false;

  ProductModel? productModel;

  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProductDetailsProvider>(
        context,
        listen: false,
      ).getProductsByLimit(
        categoryId: widget.product.categoryId,
        productId: widget.product.id!,
      );
    });
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          if (Provider.of<ProductDetailsProvider>(context, listen: false)
                      .isFirebaseLoading ==
                  false &&
              Provider.of<ProductDetailsProvider>(context, listen: false)
                      .noMoreData ==
                  false) {
            Provider.of<ProductDetailsProvider>(
              context,
              listen: false,
            ).getProductsByLimit(
              categoryId: widget.product.categoryId,
              productId: widget.product.id!,
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
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverAppBar(
              expandedHeight: seeMoreClicked == true
                  ? size.height * 1.5
                  : size.height * 0.9,
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Provider.of<CommentProvider>(
                    context,
                    listen: false,
                  ).clearDoc();
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.keyboard_backspace,
                  color: Colors.black,
                ),
              ),
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                centerTitle: true,
                background: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Stack(
                    children: [
                      widget.title != null
                          ? Positioned(
                              top: size.height * 0.12,
                              child: Text(
                                widget.title ?? '',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium!.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                      fontSize: 17,
                                    ),
                              ),
                            )
                          : const SizedBox(),
                      Positioned(
                        top: widget.title != null
                            ? size.height * 0.165
                            : size.height * 0.12,
                        child: SizedBox(
                          width: size.width - 40,
                          child: Text(
                            productModel != null
                                ? productModel!.title
                                : widget.product.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Positioned(
                        top: widget.title != null
                            ? size.height * 0.26
                            : size.height * 0.21,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              // padding: const EdgeInsets.all(5),
                              // decoration: BoxDecoration(boxShadow: [
                              //   BoxShadow(
                              //       color: Colors.black.withOpacity(0.2),
                              //       blurRadius: 0.2,
                              //       spreadRadius: 0.25),
                              // ]),
                              height: size.height * 0.28,
                              width: size.width - 40,
                              child: CustomCachedNetworkImage(
                                  url: productModel != null
                                      ? productModel!.imageUrl
                                      : widget.product.imageUrl),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Consumer6<
                                  HomeScreenProvider,
                                  ProductDetailsProvider,
                                  FavorateProvider,
                                  TrendingPageProvider,
                                  ArtistDetailsProvider,
                                  LoginProvider>(
                                builder: (context, state, state1, state2,
                                        state3, state4, state5, _) =>
                                    IconButton(
                                        padding: EdgeInsets.zero,
                                        style: const ButtonStyle(
                                            tapTargetSize: MaterialTapTargetSize
                                                .shrinkWrap,
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.white)),
                                        onPressed: () async {
                                          if (state5.isLoggdIn == true) {
                                            state.updateView(
                                              product: productModel != null
                                                  ? productModel!
                                                  : widget.product,
                                            );

                                            state4.updateView(
                                              product: productModel != null
                                                  ? productModel!
                                                  : widget.product,
                                            );

                                            state2.updateView(
                                                product: productModel != null
                                                    ? productModel!
                                                    : widget.product);

                                            state3.updateView(
                                                product: productModel != null
                                                    ? productModel!
                                                    : widget.product);

                                            await state1
                                                .incrementView(
                                                    product:
                                                        productModel != null
                                                            ? productModel!
                                                            : widget.product)
                                                .then((value) => null);
                                            state1.updateView(
                                                product: productModel != null
                                                    ? productModel!
                                                    : widget.product);
                                            launchUrl(Uri.parse(
                                                productModel != null
                                                    ? productModel!.videoUrl
                                                    : widget.product.videoUrl));

                                            setState(() {});
                                          } else {
                                            showModalBottomSheet(
                                              // enableDrag: true,

                                              isScrollControlled: true,
                                              context: context,
                                              builder: (ctx) => Padding(
                                                padding: MediaQuery.of(ctx)
                                                    .viewInsets,
                                                child: LoginScreen(
                                                  ctx: ctx,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.play_circle_fill,
                                          size: 40,
                                          color: Colors.black87,
                                        )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: widget.title != null
                            ? size.height * 0.55
                            : size.height * 0.53,
                        child: SizedBox(
                          width: size.width - 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    NumberFormatter.format(
                                        value: productModel != null
                                            ? productModel!.views
                                            : widget.product.views),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black87,
                                          fontSize: 17,
                                        ),
                                  ),
                                  Text(
                                    'Views',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    DateFormat('dd MMM').format(
                                      productModel != null
                                          ? productModel!.timestamp.toDate()
                                          : widget.product.timestamp.toDate(),
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black87,
                                          fontSize: 16,
                                        ),
                                  ),
                                  Text(
                                    DateFormat('yyyy').format(
                                      productModel != null
                                          ? productModel!.timestamp.toDate()
                                          : widget.product.timestamp.toDate(),
                                    ),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.62,
                        child: SizedBox(
                          height: size.height * 0.07,
                          width: size.width - 50,
                          child: Consumer6<
                              LocalDbDataProvider,
                              ProductDetailsProvider,
                              LoginProvider,
                              FavorateProvider,
                              TrendingPageProvider,
                              ArtistDetailsProvider>(
                            builder: (context, state, state2, state3, state4,
                                    state5, state6, _) =>
                                Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    CustomIconButton(
                                      onPressed: () {
                                        if (state3.isLoggdIn) {
                                          if (state.likedVideos.contains(
                                                  productModel != null
                                                      ? productModel!.id
                                                      : widget.product.id) ==
                                              true) {
                                            state2.unLikeButtonClicked(
                                              video: productModel != null
                                                  ? productModel!
                                                  : widget.product,
                                            );
                                            state.deleteLikedVideos(
                                                id: productModel != null
                                                    ? productModel!.id!
                                                    : widget.product.id!);
                                            setState(() {});

                                            Provider.of<HomeScreenProvider>(
                                                    context,
                                                    listen: false)
                                                .updateLikes(
                                              id: productModel != null
                                                  ? productModel!.id!
                                                  : widget.product.id!,
                                              state: CountState.increment,
                                            );
                                            state4.updateLikes(
                                              id: productModel != null
                                                  ? productModel!.id!
                                                  : widget.product.id!,
                                              state: CountState.increment,
                                            );
                                            state6.updateLikes(
                                              id: productModel != null
                                                  ? productModel!.id!
                                                  : widget.product.id!,
                                              state: CountState.increment,
                                            );
                                            state2.updateLike(
                                                id: productModel != null
                                                    ? productModel!.id!
                                                    : widget.product.id!,
                                                state: CountState.increment);
                                            state5.updateLikes(
                                              id: productModel != null
                                                  ? productModel!.id!
                                                  : widget.product.id!,
                                              state: CountState.increment,
                                            );
                                          } else {
                                            state2.likeButtonClicked(
                                              video: productModel != null
                                                  ? productModel!
                                                  : widget.product,
                                            );
                                            state2.updateLike(
                                                id: productModel != null
                                                    ? productModel!.id!
                                                    : widget.product.id!,
                                                state: CountState.decrement);

                                            state6.updateLikes(
                                              id: productModel != null
                                                  ? productModel!.id!
                                                  : widget.product.id!,
                                              state: CountState.decrement,
                                            );

                                            state4.updateLikes(
                                              id: productModel != null
                                                  ? productModel!.id!
                                                  : widget.product.id!,
                                              state: CountState.decrement,
                                            );

                                            state5.updateLikes(
                                              id: productModel != null
                                                  ? productModel!.id!
                                                  : widget.product.id!,
                                              state: CountState.decrement,
                                            );
                                            state.addeLikedVideos(
                                              id: productModel != null
                                                  ? productModel!.id!
                                                  : widget.product.id!,
                                            );
                                            Provider.of<HomeScreenProvider>(
                                                    context,
                                                    listen: false)
                                                .updateLikes(
                                                    id: productModel != null
                                                        ? productModel!.id!
                                                        : widget.product.id!,
                                                    state:
                                                        CountState.decrement);
                                            setState(() {});
                                          }
                                        } else {
                                          showModalBottomSheet(
                                            // enableDrag: true,

                                            isScrollControlled: true,
                                            context: context,
                                            builder: (ctx) => Padding(
                                              padding:
                                                  MediaQuery.of(ctx).viewInsets,
                                              child: LoginScreen(
                                                ctx: ctx,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      icon: Icon(
                                        Icons.favorite,
                                        color: state3.isLoggdIn == true &&
                                                state.likedVideos.contains(
                                                    productModel != null
                                                        ? productModel!.id
                                                        : widget.product.id)
                                            ? Colors.red
                                            : Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      NumberFormatter.format(
                                        value: productModel != null
                                            ? productModel!.likes
                                            : widget.product.likes,
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 28,
                                          ),
                                    ),
                                  ],
                                ),
                                CustomIconButton(
                                  onPressed: () async {
                                    if (state3.isLoggdIn == true &&
                                        state3.appUser != null &&
                                        state3.appUser!.favoriteVideos !=
                                            null) {
                                      if (state3.appUser!.favoriteVideos!
                                              .contains(
                                            productModel != null
                                                ? productModel!.id
                                                : widget.product.id!,
                                          ) ==
                                          true) {
                                        state4.removeSaveClicked(
                                          video: productModel != null
                                              ? productModel!
                                              : widget.product,
                                        );
                                      } else {
                                        state4.saveClicked(
                                          video: productModel != null
                                              ? productModel!
                                              : widget.product,
                                        );
                                      }
                                    } else {
                                      showModalBottomSheet(
                                        // enableDrag: true,

                                        isScrollControlled: true,
                                        context: context,
                                        builder: (ctx) => Padding(
                                          padding:
                                              MediaQuery.of(ctx).viewInsets,
                                          child: LoginScreen(
                                            ctx: ctx,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  icon: Icon(
                                    IconlyBold.bookmark,
                                    color: state3.isLoggdIn == true &&
                                            state3.appUser!.favoriteVideos !=
                                                null &&
                                            state3.appUser!.favoriteVideos!
                                                .contains(productModel != null
                                                    ? productModel!.id
                                                    : widget.product.id)
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                ),
                                CustomIconButton(
                                  onPressed: () async {
                                    DynamicLink.createLink(
                                      videoId: productModel != null
                                          ? productModel!.id!
                                          : widget.product.id!,
                                      imageUrl: productModel != null
                                          ? productModel!.imageUrl
                                          : widget.product.imageUrl,
                                      title: productModel != null
                                          ? productModel!.title
                                          : widget.product.title,
                                    );
                                  },
                                  icon: const ImageIcon(
                                    AssetImage(
                                      'assets/images/shear.png',
                                    ),
                                    size: 20,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.69,
                        child: SizedBox(
                          width: size.width - 30,
                          height: (productModel != null
                                      ? productModel!.description.length < 40
                                      : widget.product.description.length <
                                          40) &&
                                  seeMoreClicked == false
                              ? 80
                              : 180,
                          child: ListView(
                            children: [
                              ExpandableText(
                                productModel != null
                                    ? productModel!.description
                                    : widget.product.description,
                                expandText: 'See more',
                                collapseText: 'Hide',
                                onExpandedChanged: (value) {
                                  seeMoreClicked = !seeMoreClicked;

                                  setState(() {});
                                },
                                textAlign: TextAlign.justify,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                maxLines: 3,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          top: seeMoreClicked == false
                              ? size.height * 0.82
                              : size.height * 0.9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ALL COMMENTS',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                    ),
                              ),
                              kSizedBoxH5,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Consumer<LoginProvider>(
                                    builder: (context, state, _) => SizedBox(
                                      height: 45,
                                      width: 45,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                        child: state.isLoggdIn == true &&
                                                state.appUser != null &&
                                                state.appUser!.imageUrl !=
                                                    null &&
                                                state.appUser!.imageUrl!
                                                    .isNotEmpty
                                            ? CustomCachedNetworkImage(
                                                url: state.appUser!.imageUrl!,
                                              )
                                            : Container(
                                                color: Colors.black
                                                    .withOpacity(0.2),
                                                child: const Icon(
                                                  IconlyLight.profile,
                                                  color: Color.fromARGB(
                                                      255, 107, 122, 134),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                  kSizedBoxW5,
                                  SizedBox(
                                    height: 45,
                                    width: size.width - 80,
                                    child: InkWell(
                                      splashFactory: NoSplash.splashFactory,
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onTap: () async {
                                        showModalBottomSheet<dynamic>(
                                          context: context,
                                          showDragHandle: true,
                                          isScrollControlled: true,
                                          shape: Border.all(
                                              style: BorderStyle.none),
                                          builder: (context) {
                                            return CommentItem(
                                              size: size,
                                              videoId: productModel != null
                                                  ? productModel!.id!
                                                  : widget.product.id!,
                                            );
                                          },
                                        );
                                        if (Provider.of<CommentProvider>(
                                          context,
                                          listen: false,
                                        ).comments.isEmpty) {
                                          await Provider.of<CommentProvider>(
                                            context,
                                            listen: false,
                                          ).getAllCommentsByLimite(
                                              videoId: productModel != null
                                                  ? productModel!.id!
                                                  : widget.product.id!);
                                        }
                                      },
                                      child: const ReceivedMessage(
                                        message: 'Share Your Thoughts',
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Consumer<ProductDetailsProvider>(
                  builder: (context, state, _) => ExpansionPanelList(
                    elevation: 0,
                    expansionCallback: (index, isExpand) {
                      if (expand == false) {
                        state.clearCastAndCrew();
                        if (state.craft.isEmpty || state.crew.isEmpty) {
                          state.getCraft(
                              product: productModel != null
                                  ? productModel!
                                  : widget.product);
                          state.getCrew(
                              product: productModel != null
                                  ? productModel!
                                  : widget.product);
                        }
                      }
                      setState(() {
                        expand = !isExpand;
                      });
                    },
                    children: [
                      ExpansionPanel(
                        headerBuilder: (context, isExpand) => Text(
                          'Cast and Crew',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black87,
                                    fontSize: 16,
                                  ),
                        ),
                        body: Consumer<ProductDetailsProvider>(
                          builder: (context, state, _) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              height: size.height * 0.3,
                              child: CustomScrollView(
                                slivers: [
                                  state.craft.isNotEmpty
                                      ? SliverToBoxAdapter(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 20,
                                            ),
                                            child: Text(
                                              'Cast',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black87,
                                                    fontSize: 16,
                                                  ),
                                            ),
                                          ),
                                        )
                                      : const SliverToBoxAdapter(),
                                  SliverToBoxAdapter(
                                    child: SizedBox(
                                      height: size.height * 0.22,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: state.craft.length,
                                          itemBuilder: (context, index) {
                                            final craft = state.craft[index];
                                            return CategoryListItem(
                                              size: size,
                                              category: craft,
                                            );
                                          }),
                                    ),
                                  ),
                                  state.crew.isNotEmpty
                                      ? SliverToBoxAdapter(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, left: 20),
                                            child: Text(
                                              'Crew',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black87,
                                                    fontSize: 16,
                                                  ),
                                            ),
                                          ),
                                        )
                                      : const SliverToBoxAdapter(),
                                  state.crew.isNotEmpty
                                      ? SliverToBoxAdapter(
                                          child: SizedBox(
                                            height: size.height * 0.22,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: state.crew.length,
                                              itemBuilder: (context, index) {
                                                final crew = state.crew[index];
                                                return CategoryListItem(
                                                  size: size,
                                                  category: crew,
                                                );
                                              },
                                            ),
                                          ),
                                        )
                                      : const SliverToBoxAdapter(),
                                ],
                              ),
                            );
                          },
                        ),
                        isExpanded: expand,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              sliver: Consumer3<ProductDetailsProvider, LoginProvider,
                  LocalDbDataProvider>(
                builder: (context, state, state2, state3, _) =>
                    SliverList.separated(
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    final product = state.products[index];
                    return InkWell(
                      onTap: () async {
                        log(product.categoryId);
                        if (state2.isLoggdIn && productModel != null) {
                          if (state3.likedVideos.contains(productModel!.id)) {
                            await state.checkLiked(
                              product: productModel!,
                              userId: state2.appUser!.id!,
                            );
                          }

                          // // ignore: use_build_context_synchronously
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) => ProductDetailsPage(
                          //       product: product,
                          //       title: null,
                          //     ),
                          //   ),
                          // );
                        }
                        setState(() {
                          productModel = product;
                          scrollController.jumpTo(0);
                        });
                      },
                      child: Container(
                        height: 200,
                        color: Colors.grey[200],
                        child: CustomCachedNetworkImage(url: product.imageUrl),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 5,
                  ),
                ),
              ),
            ),
            Consumer<ProductDetailsProvider>(
              builder: (context, state, _) => SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                sliver: SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: state.isLoading && state.isFirebaseLoading == true
                          ? const CupertinoActivityIndicator()
                          : const SizedBox(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
