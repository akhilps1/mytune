import 'package:flutter/material.dart';

import '../../../../general/serveices/constants.dart';
import '../../../../general/utils/theam/app_colors.dart';
import '../../../sheared/custom_catched_network_image.dart';

class AllSongs extends StatelessWidget {
  const AllSongs({
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
              'All Songs',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.pink,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          kSizedBoxH5,
          SizedBox(
            height: size.height * 0.2,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              shrinkWrap: true,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                // height: size.width * 0.35,
                width: size.width * 0.7,
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: const CustomCachedNetworkImage(
                        url:
                            'https://cdn.pixabay.com/photo/2015/11/16/16/28/bird-1045954_1280.jpg'),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
