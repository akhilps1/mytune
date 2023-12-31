import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytune/features/artist_details/provider/artist_details_provider.dart';
import 'package:mytune/features/artist_details/screens/widgets/artist_profile.dart';
import 'package:mytune/features/home/models/category_model.dart';
import 'package:mytune/features/product_details/provider/product_details_provider.dart';
import 'package:mytune/features/sheared/custom_catched_network_image.dart';

import 'package:provider/provider.dart';

import '../../product_details/screens/product_details_page.dart';

class ArtistDetails extends StatefulWidget {
  const ArtistDetails({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  State<ArtistDetails> createState() => _ArtistDetailsState();
}

class _ArtistDetailsState extends State<ArtistDetails> {
  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ArtistDetailsProvider>(
        context,
        listen: false,
      ).getProductsByLimit(categoryId: widget.category.id!);
    });
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          if (Provider.of<ArtistDetailsProvider>(context, listen: false)
                      .isFirebaseLoading ==
                  false &&
              Provider.of<ArtistDetailsProvider>(context, listen: false)
                      .noMoreData ==
                  false) {
            Provider.of<ArtistDetailsProvider>(context, listen: false)
                .getProductsByLimit(
              categoryId: widget.category.id!,
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
      // appBar: AppBar(),
      body: Consumer<ArtistDetailsProvider>(
        builder: (context, state, _) => CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverAppBar(
              expandedHeight: size.height * 0.5,
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Provider.of<ArtistDetailsProvider>(
                    context,
                    listen: false,
                  ).clear();
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.keyboard_backspace,
                  color: Color.fromARGB(255, 137, 156, 224),
                ),
              ),
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                centerTitle: true,
                background: ArtistProfile(
                  category: widget.category,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(15),
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),
                    child: Center(
                        child: Text(
                      "${widget.category.totalVideos} Songs",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                    )),
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(15),
              sliver: SliverList.separated(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return Container(
                    height: 200,
                    color: Colors.grey[200],
                    child: InkWell(
                        onTap: () {
                          Provider.of<ProductDetailsProvider>(
                            context,
                            listen: false,
                          ).clear();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsPage(
                                product: product,
                                title: null,
                              ),
                            ),
                          );
                        },
                        child: CustomCachedNetworkImage(url: product.imageUrl)),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                  height: 5,
                ),
              ),
            ),
            state.isLoading == true && state.products.length > 7
                ? SliverPadding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    sliver: SliverToBoxAdapter(
                      child: Center(
                        child: state.isLoading == true
                            ? const CupertinoActivityIndicator(
                                color: Colors.black,
                              )
                            : const SizedBox(),
                      ),
                    ),
                  )
                : const SliverToBoxAdapter(),
            state.isLoading == true && state.products.isEmpty
                ? const SliverFillRemaining(
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  )
                : const SliverToBoxAdapter(),
          ],
        ),
      ),
    );
  }
}
