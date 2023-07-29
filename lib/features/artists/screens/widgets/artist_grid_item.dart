import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                left: size.height * 0.018,
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
                left: size.height * 0.018,
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
          Container(
            margin: const EdgeInsets.all(5),
            height: size.width * 0.042,
            width: size.width * 0.3,
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 197, 184, 254),
                borderRadius: BorderRadius.circular(3)),
            child: Center(
                child: Text(
              'Follow',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 13,
                  letterSpacing: 1.2),
            )),
          )
        ],
      ),
    );
  }
}
