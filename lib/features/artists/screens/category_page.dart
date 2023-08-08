import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytune/features/artist_details/provider/artist_details_provider.dart';
import 'package:mytune/features/artist_details/screens/artist_details.dart';
import 'package:mytune/features/artists/provider/artists_screen_provider.dart';
import 'package:mytune/features/artists/screens/widgets/artist_grid_item.dart';
import 'package:mytune/features/authentication/provider/login_provider.dart';
import 'package:mytune/features/home/models/category_model.dart';
import 'package:mytune/features/search/screen/search_screen.dart';
import 'package:mytune/general/utils/enum/enums.dart';

import 'package:provider/provider.dart';

import '../../sheared/app_bar_items.dart';

import '../../sheared/saerch_box.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    // Provider.of<HomeScreenProvider>(context, listen: false).getDetails();

    scrollController.addListener(
      () {
        if (scrollController.position.atEdge) {
          if (scrollController.position.pixels != 0) {
            if (Provider.of<ArtistScreenProvider>(context, listen: false)
                        .isFirebaseLoading ==
                    false &&
                Provider.of<ArtistScreenProvider>(context, listen: false)
                        .noMoreData ==
                    false) {
              Provider.of<ArtistScreenProvider>(context, listen: false)
                  .getAllArtistsByLimit();
            }
          }
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer3<ArtistScreenProvider, ArtistDetailsProvider,
        LoginProvider>(
      builder: (context, state, state1, state2, _) => CustomScrollView(
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
              title: 'Artist',
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
                      builder: (context) => const SearchScreen(
                        hintText: 'Search Artist',
                        searchState: SearchState.artist,
                        searchMode: SearchState.voice,
                      ),
                    ),
                  );
                },
                child: SearchBox(
                  size: size,
                  hint: 'Search artist',
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
          state.artists.isNotEmpty
              ? SliverPadding(
                  padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
                  sliver: SliverGrid.builder(
                    itemCount: state.artists.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 2 / 2),
                    itemBuilder: (context, index) {
                      final artist = state.artists[index];
                      if (state2.isLoggdIn == true) {
                        state1.checkFollowed(
                          artist: artist,
                          userId: state2.appUser!.id!,
                        );
                      }

                      return InkWell(
                          onTap: () async {
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ArtistDetails(
                                  category: artist,
                                ),
                              ),
                            );
                          },
                          child: ArtistGridItem(size: size, artist: artist));
                    },
                  ),
                )
              : const SliverToBoxAdapter(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: state.isLoading == true
                    ? const CupertinoActivityIndicator()
                    : const SizedBox(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
