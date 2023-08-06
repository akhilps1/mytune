import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mytune/features/product_details/screens/product_details_page.dart';

import 'package:mytune/features/sheared/custom_catched_network_image.dart';
import 'package:mytune/features/trending/provider/trending_page_provider.dart';
import 'package:provider/provider.dart';

class TrendingPage extends StatefulWidget {
  const TrendingPage({super.key});

  @override
  State<TrendingPage> createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          if (Provider.of<TrendingPageProvider>(context, listen: false)
                      .isFirebaseLoading ==
                  false &&
              Provider.of<TrendingPageProvider>(context, listen: false)
                      .noMoreData ==
                  false) {
            Provider.of<TrendingPageProvider>(context, listen: false)
                .getTrendingByLimite();
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      // controller: scrollController,
      slivers: [
        SliverAppBar(
          pinned: true,
          shadowColor: Colors.black.withOpacity(0.3),
          elevation: 1,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          forceElevated: true,
          title: const Text(
            'Trending',
            style: TextStyle(
              fontFamily: 'poppins',
            ),
          ),
        ),
        Consumer<TrendingPageProvider>(
          builder: (context, state, _) => SliverFillRemaining(
            child: MasonryGridView.builder(
                controller: scrollController,
                itemCount: state.trendingVieos.length,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  final item = state.trendingVieos[index];
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Card(
                      child: SizedBox(
                        height: index % 2 == 1 ? 220 : 270,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailsPage(product: item),
                                    ),
                                  );
                                },
                                child: CustomCachedNetworkImage(
                                  url: item.trendingImage ?? '',
                                  boxFit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }
}
