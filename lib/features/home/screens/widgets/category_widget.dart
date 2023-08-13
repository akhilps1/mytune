// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mytune/features/authentication/screens/login_screen.dart';
import 'package:mytune/features/home/provider/home_screen_provider.dart';

import 'package:provider/provider.dart';

import 'package:mytune/features/home/models/category_model.dart';
import 'package:mytune/general/serveices/number_converter.dart';

import '../../../../general/utils/enum/enums.dart';
import '../../../artist_details/provider/artist_details_provider.dart';
import '../../../artist_details/screens/artist_details.dart';
import '../../../artists/provider/artists_screen_provider.dart';
import '../../../authentication/provider/login_provider.dart';
import '../../../sheared/custom_catched_network_image.dart';
import '../../provider/local_db_data_provider.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({
    super.key,
    required this.size,
    required this.categories,
    required this.name,
    required this.color,
  });

  final Size size;
  final List<CategoryModel> categories;
  final String name;
  final Color color;

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  void initState() {
    // for (var category in widget.categories) {
    //   if (Provider.of<LoginProvider>(context, listen: false).isLoggdIn ==
    //       true) {
    //     Provider.of<LocalDbDataProvider>(context, listen: false).checkFollowed(
    //       artist: category,
    //       userId:
    //           Provider.of<LoginProvider>(context, listen: false).appUser!.id!,
    //     );
    //   }
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              widget.name,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: widget.color,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          SizedBox(
            height: widget.size.height * 0.23,
            child: Consumer2<LoginProvider, ArtistDetailsProvider>(
              builder: (context, state, state1, _) => ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.categories.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final category = widget.categories[index];

                  return Stack(alignment: Alignment.center, children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 25, top: 10),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                height: widget.size.width * 0.29,
                                width: widget.size.width * 0.26,
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
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: widget.size.width * 0.06,
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
                              category.categoryName.split(' ')[0],
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: const Color.fromARGB(
                                        255, 119, 119, 111),
                                  ),
                            ),
                            Text(
                              '${NumberFormatter.format(value: category.followers)} FOLLOWERS',
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11,
                                    color: const Color.fromARGB(
                                        255, 119, 119, 111),
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    index == 2
                        ? const SizedBox()
                        : Positioned(
                            top: widget.size.width * 0.03,
                            right: widget.size.width * 0.02,
                            child: InkWell(
                              onTap: () {},
                              child: FollowButton(
                                size: widget.size,
                                artist: category,
                              ),
                            ),
                          ),
                  ]);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FollowButton extends StatelessWidget {
  const FollowButton({
    Key? key,
    required this.artist,
    required this.size,
  }) : super(key: key);
  final CategoryModel artist;

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Consumer5<LoginProvider, ArtistDetailsProvider, ArtistScreenProvider,
        LocalDbDataProvider, HomeScreenProvider>(
      builder: (context, state, state1, state2, state3, state4, _) => InkWell(
        onTap: () async {
          if (state.isLoggdIn == true) {
            if (state3.followedArtist.contains(artist.id) == true) {
              await state1.unFollowButtonClicked(artist: artist);
              state3.deleteFollowedArtist(id: artist.id!);
              state2.updateFollowers(
                  id: artist.id!, state: CountState.decrement);
              state4.updateFollowers(
                  id: artist.id!, state: CountState.decrement);
            } else {
              await state1.followButtonClicked(artist: artist);
              state3.addFollowedArtist(id: artist.id!);
              state2.updateFollowers(
                  id: artist.id!, state: CountState.increment);
              state4.updateFollowers(
                  id: artist.id!, state: CountState.increment);
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
        child: Container(
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
            child: state3.followedArtist.contains(artist.id) == true &&
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
      ),
    );
  }

  Widget customText(BuildContext context, String char) {
    return Text(
      char,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 9,
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
