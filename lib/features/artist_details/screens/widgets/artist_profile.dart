// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mytune/features/artist_details/provider/artist_details_provider.dart';

import 'package:mytune/features/artists/provider/artists_screen_provider.dart';
import 'package:mytune/features/authentication/provider/login_provider.dart';
import 'package:mytune/features/authentication/screens/login_screen.dart';

import 'package:mytune/features/home/models/category_model.dart';
import 'package:mytune/features/home/provider/home_screen_provider.dart';
import 'package:mytune/features/home/provider/local_db_data_provider.dart';
import 'package:mytune/features/product_details/provider/product_details_provider.dart';

import 'package:mytune/features/sheared/custom_catched_network_image.dart';
import 'package:mytune/general/serveices/number_converter.dart';
import 'package:mytune/general/utils/enum/enums.dart';
import 'package:provider/provider.dart';

class ArtistProfile extends StatefulWidget {
  const ArtistProfile({
    Key? key,
    required this.category,
  }) : super(key: key);

  final CategoryModel category;

  @override
  State<ArtistProfile> createState() => _ArtistProfileState();
}

class _ArtistProfileState extends State<ArtistProfile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer6<ArtistDetailsProvider, ArtistScreenProvider, LoginProvider,
        LocalDbDataProvider, HomeScreenProvider, ProductDetailsProvider>(
      builder: (context, state, state2, state3, state4, state5, state6, _) =>
          Container(
        // height: size.height * 0.47,
        color: const Color.fromARGB(255, 247, 252, 255),
        padding: const EdgeInsets.only(bottom: 15),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              bottom: size.width * 0.58,
              right: size.width * 0.38,
              child: Container(
                height: size.width * 0.7,
                width: size.width * 0.7,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 137, 156, 224),
                    borderRadius: BorderRadius.all(Radius.circular(100))),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: size.width * 0.48,
                width: size.width * 0.4,
                color: const Color.fromARGB(255, 255, 209, 126),
              ),
            ),
            Positioned(
              bottom: size.height * 0.3,
              left: size.width * 0.47,
              child: Container(
                height: size.width * 0.55,
                width: size.width * 0.55,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 175, 162),
                    borderRadius: BorderRadius.all(Radius.circular(100))),
              ),
            ),
            SizedBox(
              width: size.width * 0.9,
              height: size.height * 0.35,
              child: Card(
                elevation: 1,
                surfaceTintColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      widget.category.categoryName,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                            color: const Color.fromARGB(255, 69, 68, 65),
                            fontSize: 20,
                            letterSpacing: 1.1,
                          ),
                    ),
                    Text(
                      widget.category.proffession?.replaceAll(',', ' |') ?? '',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w700,
                            color: const Color.fromARGB(255, 69, 68, 65),
                            fontSize: 12,
                            letterSpacing: 1.1,
                          ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                NumberFormatter.format(
                                    value: widget.category.followers),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: const Color.fromARGB(
                                          255, 108, 149, 168),
                                      fontSize: 20,
                                      letterSpacing: 1.2,
                                    ),
                              ),
                              Text(
                                'Followers',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: const Color.fromARGB(
                                            255, 183, 183, 182),
                                        fontSize: 15,
                                        letterSpacing: 1.2),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Text(
                                NumberFormatter.format(
                                    value: widget.category.totalLikes ?? 0),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: const Color.fromARGB(
                                            255, 108, 149, 168),
                                        fontSize: 20,
                                        letterSpacing: 1.2),
                              ),
                              const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: size.width * 0.6,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 155, 169, 231))),
                        onPressed: () async {
                          if (state3.isLoggdIn == true) {
                            if (state4.followedArtist
                                    .contains(widget.category.id) ==
                                true) {
                              await state.unFollowButtonClicked(
                                  artist: widget.category);
                              state4.deleteFollowedArtist(
                                  id: widget.category.id!);
                              state2.updateFollowers(
                                  id: widget.category.id!,
                                  state: CountState.decrement);
                              state5.updateFollowers(
                                  id: widget.category.id!,
                                  state: CountState.decrement);

                              state6.updateFollowers(
                                  id: widget.category.id!,
                                  state: CountState.decrement);
                            } else {
                              await state.followButtonClicked(
                                  artist: widget.category);
                              state4.addFollowedArtist(id: widget.category.id!);
                              state2.updateFollowers(
                                  id: widget.category.id!,
                                  state: CountState.increment);
                              state5.updateFollowers(
                                  id: widget.category.id!,
                                  state: CountState.increment);

                              state6.updateFollowers(
                                  id: widget.category.id!,
                                  state: CountState.increment);
                            }
                            setState(() {});
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
                        child: Text(
                          state4.followedArtist.contains(widget.category.id) ==
                                      true &&
                                  state3.isLoggdIn == true
                              ? 'Followed'
                              : 'Follow',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 18,
                                  letterSpacing: 1.2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.1,
              child: SizedBox(
                width: size.width * 0.25,
                height: size.width * 0.25,
                child: Card(
                  // color: Colors.amber,
                  surfaceTintColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CustomCachedNetworkImage(
                          url: widget.category.imageUrl),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              left: 15,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.keyboard_backspace,
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class CustomHalfCircleClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final Path path = Path();
//     path.lineTo(0.0, size.height / 2);
//     path.lineTo(size.width, size.height / 2);
//     path.lineTo(size.width, 0);
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }
