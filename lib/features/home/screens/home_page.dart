import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytune/features/home/models/product_model.dart';
import 'package:mytune/features/home/provider/home_screen_provider.dart';
import 'package:mytune/features/home/screens/widgets/custom_corousel_slider.dart';
import 'package:mytune/features/home/screens/widgets/today_release_widget.dart';
import 'package:mytune/features/home/screens/widgets/top_three_this_week.dart';
import 'package:mytune/features/product_details/screens/product_details_page.dart';
import 'package:mytune/features/user_details/provider/user_details_provider.dart';
import 'package:mytune/general/utils/enum/enums.dart';

import 'package:provider/provider.dart';

import '../../authentication/provider/login_provider.dart';
import '../../search/screen/search_screen.dart';
import '../../sheared/custom_catched_network_image.dart';
import '../../sheared/saerch_box.dart';

import '../../sheared/app_bar_items.dart';
import 'widgets/category_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    // Provider.of<HomeScreenProvider>(context, listen: false).getDetails();
    final user = Provider.of<LoginProvider>(
      context,
      listen: false,
    ).user;
    if (user != null) {
      Provider.of<UserDetailsProvider>(
        context,
        listen: false,
      ).getUserDetails(userId: user.uid);
    }
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          if (Provider.of<HomeScreenProvider>(context, listen: false)
                      .isFirebaseLoading ==
                  false &&
              Provider.of<HomeScreenProvider>(context, listen: false)
                      .noMoreData ==
                  false) {
            Provider.of<HomeScreenProvider>(context, listen: false)
                .getAllProductsByLimit();
          }
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      child: Consumer<HomeScreenProvider>(
        builder: (context, state, _) => CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverAppBar(
              elevation: 0,
              snap: false,
              pinned: true,
              floating: false,
              surfaceTintColor: Colors.white,

              flexibleSpace: AppBarItems(
                size: size,
                drowerButtonClicked: () {},
                title: 'HI,IAMI',
              ),

              bottom: PreferredSize(
                preferredSize: Size(double.infinity, size.height * 0.017),
                child: InkWell(
                  splashFactory: NoSplash.splashFactory,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SearchScreen<ProductModel>(
                          hintText: 'Search songs',
                          searchState: SearchState.video,
                        ),
                      ),
                    );
                  },
                  child: SearchBox(
                    size: size,
                    hint: 'Search songs',
                    enabled: false,
                  ),
                ),
              ),

              // flexibleSpace: AppBarItems(size: size), //FlexibleSpaceBar
              expandedHeight: size.height * 0.24,
              backgroundColor: Colors.white,
              shadowColor: Colors.transparent,

              //<Widget>[]
            ),
            state.banner.isNotEmpty
                ? SliverToBoxAdapter(
                    child: SizedBox(
                      // height: size.height * 0.08,
                      child: CustomCorouselSlider(
                        size: size,
                        banners: state.banner,
                      ),
                    ),
                  )
                : const SliverToBoxAdapter(),
            state.categories.isNotEmpty
                ? SliverToBoxAdapter(
                    child: SizedBox(
                        height: size.height * 0.26,
                        child: CategoryWidget(
                          size: size,
                          categories: state.categories.sublist(0, 3),
                          name: 'Singers',
                          color: Colors.pink,
                        )),
                  )
                : const SliverToBoxAdapter(),
            state.todayRelease.isNotEmpty
                ? SliverPadding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    sliver: SliverList.separated(
                      itemCount: 1,
                      itemBuilder: (context, index) => SizedBox(
                        // color: Colors.blue,
                        height: size.height * 0.28,
                        // width: size.width - 20,
                        child: TodayReleaseWidget(
                          size: size,
                          todayRelease: state.todayRelease,
                        ),
                      ),
                      separatorBuilder: (context, inddex) => const SizedBox(),
                    ),
                  )
                : const SliverToBoxAdapter(),
            state.topThreeRelease.isNotEmpty
                ? SliverToBoxAdapter(
                    child: SizedBox(
                      height: size.height * 0.26,
                      child: TopThreeThisWeek(
                        size: size,
                        topThreeRelease: state.topThreeRelease,
                      ),
                    ),
                  )
                : const SliverToBoxAdapter(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 14, bottom: 5),
                child: Text(
                  'All Songs',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.pink,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
            state.allProducts.isNotEmpty
                ? SliverPadding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    sliver: SliverGrid.builder(
                      itemCount: state.allProducts.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 3 / 2),
                      itemBuilder: (context, index) {
                        final product = state.allProducts[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsPage(
                                  product: product,
                                  title: '',
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: size.width * 0.35,
                            width: size.width * 0.6,
                            child: SizedBox(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CustomCachedNetworkImage(
                                  url: product.imageUrl,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const SliverToBoxAdapter(),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              sliver: SliverToBoxAdapter(
                child: Center(
                  child: state.isLoading && state.isFirebaseLoading == true
                      ? const CupertinoActivityIndicator()
                      : const SizedBox(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
