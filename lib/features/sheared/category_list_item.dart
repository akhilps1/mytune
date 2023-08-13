// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:mytune/features/home/models/product_model.dart';
import 'package:mytune/features/product_details/provider/product_details_provider.dart';

import '../../general/serveices/number_converter.dart';
import '../../general/utils/enum/enums.dart';
import '../artist_details/provider/artist_details_provider.dart';
import '../artist_details/screens/artist_details.dart';
import '../artists/provider/artists_screen_provider.dart';
import '../authentication/provider/login_provider.dart';
import '../authentication/screens/login_screen.dart';
import '../home/models/category_model.dart';
import '../home/provider/home_screen_provider.dart';
import '../home/provider/local_db_data_provider.dart';
import 'custom_catched_network_image.dart';

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({
    Key? key,
    required this.size,
    required this.category,
    required this.role,
  }) : super(key: key);

  final Size size;
  final CategoryModel category;
  final String role;
  // final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(right: 25, top: 10),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
            child: SizedBox(
              height: size.width * 0.29,
              width: size.width * 0.28,
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ArtistDetails(
                        category: category,
                      ),
                    ),
                  );
                },
                child: CustomCachedNetworkImage(
                  url: category.imageUrl,
                ),
              ),
            ),
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: size.width * 0.06,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ArtistDetails(
                  category: category,
                ),
              ),
            );
          },
          child: Column(
            children: [
              Text(
                category.categoryName.split(' ').first,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: const Color.fromARGB(255, 119, 119, 111),
                    ),
              ),
              Text(
                '${NumberFormatter.format(value: category.followers)} FOLLOWERS',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      color: const Color.fromARGB(255, 119, 119, 111),
                    ),
              ),
              Text(
                category.proffession ?? '',
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: const Color.fromARGB(255, 119, 119, 111),
                    ),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        top: size.width * 0.03,
        right: size.width * 0.02,
        child: Consumer6<
            LoginProvider,
            ArtistDetailsProvider,
            ArtistScreenProvider,
            LocalDbDataProvider,
            HomeScreenProvider,
            ProductDetailsProvider>(
          builder:
              (context, state, state1, state2, state3, state4, state5, _) =>
                  InkWell(
            onTap: () async {
              if (state.isLoggdIn == true) {
                if (state3.followedArtist.contains(category.id) == true) {
                  await state1.unFollowButtonClicked(artist: category);
                  state3.deleteFollowedArtist(id: category.id!);
                  state2.updateFollowers(
                      id: category.id!, state: CountState.decrement);
                  state4.updateFollowers(
                      id: category.id!, state: CountState.decrement);
                  state5.updateFollowers(
                      id: category.id!, state: CountState.decrement);
                } else {
                  await state1.followButtonClicked(artist: category);
                  state3.addFollowedArtist(id: category.id!);
                  state2.updateFollowers(
                      id: category.id!, state: CountState.increment);
                  state4.updateFollowers(
                      id: category.id!, state: CountState.increment);
                  state5.updateFollowers(
                      id: category.id!, state: CountState.increment);
                }
              } else {
                showModalBottomSheet(
                  // enableDrag: true,

                  isScrollControlled: true,
                  context: context,
                  builder: (ctx) => Padding(
                    padding: MediaQuery.of(ctx).viewInsets,
                    child: LoginScreen(
                      ctx: ctx,
                    ),
                  ),
                );
              }
            },
            child: FollowButton(
              size: size,
              artist: category,
            ),
          ),
        ),
      ),
    ]);
  }
}

class FollowButton extends StatelessWidget {
  const FollowButton({
    Key? key,
    required this.size,
    required this.artist,
  }) : super(key: key);

  final Size size;
  final CategoryModel artist;

  @override
  Widget build(BuildContext context) {
    return Consumer2<LoginProvider, LocalDbDataProvider>(
      builder: (context, state, state1, _) => Container(
        height: size.width * 0.29,
        width: 15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          gradient: const RadialGradient(
              stops: [
                -1,
                2,
              ],
              focalRadius: 1,
              radius: 25,
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 15, 59, 94),
              ]),
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: state1.followedArtist.contains(artist.id) == true &&
                  state.isLoggdIn == true
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customText(context, 'F'),
                    customText(context, 'O'),
                    customText(context, 'L'),
                    customText(context, 'L'),
                    customText(context, 'O'),
                    customText(context, 'W'),
                    customText(context, 'E'),
                    customText(context, 'D'),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customText(context, 'F'),
                    customText(context, 'O'),
                    customText(context, 'L'),
                    customText(context, 'L'),
                    customText(context, 'O'),
                    customText(context, 'W'),
                  ],
                ),
        ),
      ),
    );
  }

  Widget customText(BuildContext context, String char) {
    return Text(
      char,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 10,
            color: const Color.fromARGB(
              255,
              119,
              119,
              111,
            ),
          ),
    );
  }
}
