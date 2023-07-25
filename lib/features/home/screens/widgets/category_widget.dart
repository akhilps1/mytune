import 'package:flutter/material.dart';

import '../../../../general/serveices/constants.dart';
import '../../../sheared/custom_catched_network_image.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.size,
  });

  final Size size;

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
              'Singers',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.pink,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          SizedBox(
            height: size.height * 0.21,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              shrinkWrap: true,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                height: size.width * 0.30,
                width: size.width * 0.33,
                child: Stack(children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 35, horizontal: 18),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                      child: CustomCachedNetworkImage(
                          url:
                              'https://cdn.pixabay.com/photo/2015/11/16/16/28/bird-1045954_1280.jpg'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: InkWell(
                        onTap: () {},
                        child: FollowButton(size: size),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'JOHN \n 100K FOLLOWERS',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: const Color.fromARGB(255, 119, 119, 111),
                          ),
                    ),
                  ),
                ]),
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
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.width * 0.25,
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
        child: Column(
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
    );
  }

  Widget customText(BuildContext context, String char) {
    return Text(
      char,
      style: Theme.of(context).textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 11,
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
