// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'package:mytune/features/product_details/provider/product_details_provider.dart';
import 'package:mytune/features/search/provider/saerch_provider.dart';
import 'package:mytune/general/utils/enum/enums.dart';

import '../../artist_details/screens/artist_details.dart';
import '../../artists/screens/widgets/artist_grid_item.dart';
import '../../product_details/screens/product_details_page.dart';
import '../../sheared/custom_catched_network_image.dart';

BuildContext? ctx;

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
    required this.hintText,
    required this.searchState,
    required this.searchMode,
  });
  final String hintText;
  final SearchState searchState;
  final SearchState searchMode;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        // backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.keyboard_backspace),
        ),
        actions: [
          SizedBox(
            width: size.width * 0.85,
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.search,
              onChanged: (value) {
                Provider.of<SearchProvider>(context, listen: false).clear();
              },
              onSubmitted: (value) {
                if (widget.searchState == SearchState.video) {
                  Provider.of<SearchProvider>(context, listen: false)
                      .searchProductsByLimit(productName: value);
                } else {
                  Provider.of<SearchProvider>(context, listen: false)
                      .searchCategoryByLimit(categoryName: value);
                }
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                hintText: widget.hintText,
                suffixIcon: SizedBox(
                  width: size.width * 0.24,
                  child: Row(
                    children: [
                      IconButton(
                        splashRadius: 10,
                        padding: EdgeInsets.zero,
                        style: const ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          if (controller.text.isNotEmpty) {
                            controller.clear();

                            Provider.of<SearchProvider>(context, listen: false)
                                .clear();
                          }
                        },
                        icon: const Icon(
                          Icons.close,
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        splashRadius: 15,
                        style: const ButtonStyle(
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () async {
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (context) {
                              ctx = context;
                              return DialogItem(
                                size: size,
                                searchState: widget.searchState,
                                controller: controller,
                              );
                            },
                          );
                        },
                        icon: const Icon(
                          Icons.keyboard_voice_outlined,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],

        surfaceTintColor: Colors.white,
        shadowColor: Colors.black.withOpacity(0.5),
      ),
      body: Consumer<SearchProvider>(
        builder: (context, value, _) => Container(
          color: Colors.grey[100],
          child: CustomScrollView(
            slivers: [
              widget.searchState == SearchState.video
                  ? SliverPadding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      sliver: Consumer<SearchProvider>(
                        builder: (context, state, _) => SliverList.separated(
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
                                        builder: (context) =>
                                            ProductDetailsPage(
                                                product: product),
                                      ),
                                    );
                                  },
                                  child: CustomCachedNetworkImage(
                                      url: product.imageUrl)),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 5,
                          ),
                        ),
                      ),
                    )
                  : Consumer<SearchProvider>(
                      builder: (context, state, _) => SliverPadding(
                        padding: EdgeInsets.only(
                            left: size.width * 0.07,
                            right: size.width * 0.07,
                            top: 15),
                        sliver: SliverGrid.builder(
                          itemCount: state.categories.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                  childAspectRatio: 2 / 2),
                          itemBuilder: (context, index) {
                            final artist = state.categories[index];
                            return InkWell(
                                onTap: () {
                                  Provider.of<ProductDetailsProvider>(
                                    context,
                                    listen: false,
                                  ).clear();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ArtistDetails(
                                        category: artist,
                                      ),
                                    ),
                                  );
                                },
                                child:
                                    ArtistGridItem(size: size, artist: artist));
                          },
                        ),
                      ),
                    ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                sliver: SliverToBoxAdapter(
                  child: Center(
                    child: value.isLoading && value.products.length > 7 ||
                            value.categories.length > 7
                        ? const CupertinoActivityIndicator(
                            color: Colors.black,
                          )
                        : const SizedBox(),
                  ),
                ),
              ),
              value.isLoading == true
                  ? const SliverFillRemaining(
                      child: Center(
                        child: CupertinoActivityIndicator(),
                      ),
                    )
                  : const SliverToBoxAdapter(),
            ],
          ),
        ),
      ),
    );
  }
}

class DialogItem extends StatefulWidget {
  const DialogItem({
    Key? key,
    required this.size,
    required this.searchState,
    required this.controller,
  }) : super(key: key);

  final Size size;
  final SearchState searchState;
  final TextEditingController controller;

  @override
  State<DialogItem> createState() => _DialogItemState();
}

class _DialogItemState extends State<DialogItem> {
  SpeechToText? speech;

  bool isListen = false;
  @override
  void initState() {
    speech = SpeechToText();
    listen(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        SizedBox(
          height: widget.size.height * 0.45,
          width: widget.size.width - 50,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(
                    'Say Somthing',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: const Color.fromARGB(
                            255,
                            119,
                            119,
                            111,
                          ),
                        ),
                  ),
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: Lottie.asset(
                      'assets/lottie/voice.json',
                      fit: BoxFit.contain,
                    ),
                  ),
                  OutlinedButton(
                      style: const ButtonStyle(
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                10,
                              ),
                            ),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        await Provider.of<SearchProvider>(
                          context,
                          listen: false,
                        ).listen(widget.searchState);
                      },
                      child: const Text('Try again'))
                ],
              ),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }

  Future<void> listen(BuildContext context) async {
    if (!isListen) {
      bool avail = await speech!.initialize();
      if (avail) {
        setState(() {
          isListen = true;
        });
        await speech!.listen(onResult: (value) async {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            widget.controller.text = value.recognizedWords;
          });
          // if (widget.searchState == SearchState.video) {
          //   Provider.of<SearchProvider>(context, listen: false)
          //       .searchProductsByLimit(productName: value.recognizedWords);
          // } else {
          //   Provider.of<SearchProvider>(context, listen: false)
          //       .searchCategoryByLimit(categoryName: value.recognizedWords);
          // }
        });
      }
    } else {
      isListen = false;

      await speech!.stop();
    }
  }
}
