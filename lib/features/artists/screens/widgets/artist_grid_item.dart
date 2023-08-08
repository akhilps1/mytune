import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytune/features/artist_details/provider/artist_details_provider.dart';
import 'package:mytune/features/artists/provider/artists_screen_provider.dart';
import 'package:mytune/features/authentication/provider/login_provider.dart';
import 'package:mytune/features/home/provider/local_db_data_provider.dart';
import 'package:mytune/general/serveices/custom_toast.dart';
import 'package:mytune/general/utils/enum/enums.dart';
import 'package:provider/provider.dart';

import '../../../../general/serveices/number_converter.dart';
import '../../../home/models/category_model.dart';
import '../../../sheared/custom_catched_network_image.dart';

class ArtistGridItem extends StatelessWidget {
  const ArtistGridItem({
    super.key,
    required this.size,
    required this.artist,
  });

  final Size size;
  final CategoryModel artist;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      height: size.width * 0.4,
      width: size.width * 0.4,
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: size.width * 0.34,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.38,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CustomCachedNetworkImage(
                          url: artist.imageUrl,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: size.height * 0.025,
                left: size.height * 0.03,
                child: SizedBox(
                  width: size.width * 0.28,
                  child: Text(
                    artist.categoryName,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 15,
                        ),
                  ),
                ),
              ),
              Positioned(
                bottom: size.height * 0.005,
                left: size.height * 0.03,
                child: SizedBox(
                  width: size.width * 0.28,
                  child: Text(
                    '${NumberFormatter.format(value: artist.followers)} Followers',
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 11,
                        ),
                  ),
                ),
              )
            ],
          ),
          Consumer4<LoginProvider, ArtistDetailsProvider, ArtistScreenProvider,
              LocalDbDataProvider>(
            builder: (context, state, state1, state2, state3, _) => InkWell(
              onTap: () async {
                if (state.isLoggdIn == true) {
                  if (state3.followedArtist.contains(artist.id) == true) {
                    await state1.unFollowButtonClicked(artist: artist);
                    state3.deleteFollowedArtist(id: artist.id!);
                    state2.updateFollowers(
                        id: artist.id!, state: CountState.decrement);
                  } else {
                    await state1.followButtonClicked(artist: artist);
                    state3.addFollowedArtist(id: artist.id!);
                    state2.updateFollowers(
                        id: artist.id!, state: CountState.increment);
                  }
                } else {
                  CustomToast.errorToast('Please login');
                }
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                height: size.width * 0.052,
                width: size.width * 0.3,
                decoration: BoxDecoration(
                    color: state3.followedArtist.contains(artist.id) == true &&
                            state1.isFollowed == true &&
                            state.isLoggdIn == true
                        ? const Color.fromARGB(255, 254, 181, 201)
                        : const Color.fromARGB(255, 197, 184, 254),
                    borderRadius: BorderRadius.circular(3)),
                child: Center(
                    child: Text(
                  state3.followedArtist.contains(artist.id) == true &&
                          state1.isFollowed == true &&
                          state.isLoggdIn == true
                      ? 'Followed'
                      : 'Follow',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 13,
                      letterSpacing: 1.2),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}
