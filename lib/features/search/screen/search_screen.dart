import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mytune/features/search/provider/saerch_provider.dart';
import 'package:mytune/general/utils/enum/enums.dart';
import 'package:provider/provider.dart';

import 'package:speech_to_text/speech_to_text.dart';

import '../../artist_details/screens/artist_details.dart';
import '../../artists/screens/widgets/artist_grid_item.dart';
import '../../product_details/screens/product_details_page.dart';
import '../../sheared/custom_catched_network_image.dart';

class SearchScreen<T> extends StatefulWidget {
  const SearchScreen({
    super.key,
    required this.hintText,
    required this.searchState,
  });
  final String hintText;
  final SearchState searchState;

  @override
  State<SearchScreen<T>> createState() => _SearchScreenState<T>();
}

class _SearchScreenState<T> extends State<SearchScreen<T>> {
  SpeechToText? speech;
  bool isListen = false;

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    speech = SpeechToText();
    super.initState();
  }

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
                          controller.clear();
                          Provider.of<SearchProvider>(context, listen: false)
                              .clear();
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
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              listen(ctx);
                              return Column(
                                children: [
                                  const Spacer(),
                                  SizedBox(
                                    height: size.height * 0.45,
                                    width: size.width - 50,
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Say Somthing',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
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
                                                  shape:
                                                      MaterialStatePropertyAll(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(
                                                          10,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  listen(ctx);
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
      body: Container(
        color: Colors.grey[100],
        child: CustomScrollView(
          slivers: [
            widget.searchState == SearchState.video
                ? SliverPadding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    sliver: Consumer<SearchProvider>(
                      builder: (context, state, _) => SliverList.separated(
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return Container(
                            height: 200,
                            color: Colors.grey[200],
                            child:
                                CustomCachedNetworkImage(url: product.imageUrl),
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
            Consumer<SearchProvider>(
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
      ),
    );
  }

  void listen(BuildContext ctx) async {
    if (!isListen) {
      bool avail = await speech!.initialize();
      if (avail) {
        setState(() {
          isListen = true;
        });
        speech!.listen(onResult: (value) {
          if (widget.searchState == SearchState.video) {
            Provider.of<SearchProvider>(ctx, listen: false)
                .searchProductsByLimit(productName: value.recognizedWords);
          } else {
            Provider.of<SearchProvider>(ctx, listen: false)
                .searchCategoryByLimit(categoryName: value.recognizedWords);
          }

          setState(() {
            controller.text = value.recognizedWords;

            Navigator.pop(ctx);
          });
        });
      }
    } else {
      setState(() {
        isListen = false;
      });
      speech!.stop();
    }
  }
}
