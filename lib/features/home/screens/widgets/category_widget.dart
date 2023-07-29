import 'package:flutter/material.dart';
import 'package:mytune/features/home/models/category_model.dart';
import 'package:mytune/general/serveices/number_converter.dart';
import '../../../sheared/custom_catched_network_image.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.size,
    required this.categories,
  });

  final Size size;
  final List<CategoryModel> categories;

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
            height: size.height * 0.2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final category = categories[index];
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
                          height: size.width * 0.25,
                          width: size.width * 0.255,
                          child: CustomCachedNetworkImage(
                            url: category.imageUrl,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: size.width * 0.06,
                    child: Column(
                      children: [
                        Text(
                          category.categoryName,
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
                                color: const Color.fromARGB(255, 119, 119, 111),
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
                                fontSize: 12,
                                color: const Color.fromARGB(255, 119, 119, 111),
                              ),
                        ),
                      ],
                    ),
                  ),
                  index == 2
                      ? const SizedBox()
                      : Positioned(
                          top: size.width * 0.03,
                          right: size.width * 0.02,
                          child: InkWell(
                            onTap: () {},
                            child: FollowButton(size: size),
                          ),
                        ),
                ]);
              },
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
