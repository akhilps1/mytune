// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:mytune/features/home/models/product_model.dart';
import 'package:mytune/features/product_details/screens/widgets/custom_icon_button.dart';
import 'package:mytune/features/sheared/category_list_item.dart';
import 'package:mytune/features/sheared/custom_catched_network_image.dart';
import 'package:mytune/general/serveices/number_converter.dart';
import 'package:provider/provider.dart';

import '../provider/product_details_rovider.dart';

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
    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: size.height * 0.66,
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Provider.of<ProductDetailsProvider>(
                  context,
                  listen: false,
                ).clear();
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
                              widget.title ?? widget.product.title,
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
                      top: size.height * 0.165,
                      child: SizedBox(
                        width: size.width - 40,
                        child: Text(
                          'Olam Up Video Song | Dabzee | Anarkali | Jahaan | Chemban Vinod Jose',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
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
                      top: size.height * 0.26,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 0.2,
                                  spreadRadius: 0.25),
                            ]),
                            height: size.height * 0.28,
                            width: size.width - 40,
                            child: CustomCachedNetworkImage(
                                url: widget.product.imageUrl),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: IconButton(
                                padding: EdgeInsets.zero,
                                style: const ButtonStyle(
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.white)),
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.play_circle_fill,
                                  size: 40,
                                  color: Colors.black87,
                                )),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.55,
                      child: SizedBox(
                        width: size.width - 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  widget.product.likes.toString(),
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
                                    widget.product.timestamp.toDate(),
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
                                    widget.product.timestamp.toDate(),
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
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.62,
                      child: SizedBox(
                        height: size.height * 0.07,
                        width: size.width - 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                CustomIconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.favorite,
                                  ),
                                ),
                                Text(
                                  NumberFormatter.format(
                                    value: widget.product.likes,
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
                              onPressed: () {},
                              icon: const Icon(Icons.bookmark_border_outlined),
                            ),
                            CustomIconButton(
                              onPressed: () {},
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
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: ExpansionPanelList(
                elevation: 0,
                expansionCallback: (index, isExpand) {
                  if (expand == false) {
                    if (Provider.of<ProductDetailsProvider>(
                          context,
                          listen: false,
                        ).craft.isEmpty ||
                        Provider.of<ProductDetailsProvider>(
                          context,
                          listen: false,
                        ).crew.isEmpty) {
                      Provider.of<ProductDetailsProvider>(
                        context,
                        listen: false,
                      ).getCraft(product: widget.product);
                      Provider.of<ProductDetailsProvider>(
                        context,
                        listen: false,
                      ).getCrew(product: widget.product);
                    }
                  }
                  setState(() {
                    expand = !isExpand;
                  });
                },
                children: [
                  ExpansionPanel(
                    headerBuilder: (context, isExpand) => Text(
                      'Craft and Crew',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
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
                              SliverToBoxAdapter(
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
                              ),
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
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            sliver: Consumer<ProductDetailsProvider>(
              builder: (context, state, _) => SliverList.separated(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return Container(
                    height: 200,
                    color: Colors.grey[200],
                    child: CustomCachedNetworkImage(url: product.imageUrl),
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
                child: Center(
                  child: state.isLoading && state.isFirebaseLoading == true
                      ? const CupertinoActivityIndicator()
                      : const SizedBox(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
