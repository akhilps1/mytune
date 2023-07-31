import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytune/features/artist_details/screens/artist_details.dart';
import 'package:mytune/features/artists/provider/artists_screen_provider.dart';
import 'package:mytune/features/artists/screens/widgets/artist_grid_item.dart';

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
    return Consumer<ArtistScreenProvider>(
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
              title: 'Artist',
            ),

            bottom: PreferredSize(
              preferredSize: Size(double.infinity, size.height * 0.017),
              child: SearchBox(
                size: size,
                hint: 'Search artist',
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
                  padding: EdgeInsets.only(
                      left: size.width * 0.07,
                      right: size.width * 0.07,
                      top: 15),
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
                          child: ArtistGridItem(size: size, artist: artist));
                    },
                  ),
                )
              : const SliverToBoxAdapter(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: state.isLoading && state.isLoading == true
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
