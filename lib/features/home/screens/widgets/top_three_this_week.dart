import 'package:flutter/material.dart';

import '../../../../general/serveices/constants.dart';
import '../../../../general/utils/theam/app_colors.dart';
import '../../../sheared/custom_catched_network_image.dart';

class TopThreeThisWeek extends StatelessWidget {
  const TopThreeThisWeek({
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
              'Top 3 This Week',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.pink,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          SizedBox(
            height: size.height * 0.18,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              shrinkWrap: true,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                height: size.width * 0.30,
                width: size.width * 0.5,
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  // height: 50,
                  // width: size.width * 0.5,
                  decoration: BoxDecoration(
                    color: index == 0
                        ? AppColor.containerColor2
                        : index == 1
                            ? AppColor.containerColors3
                            : AppColor.containerColor4,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Stack(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: CustomCachedNetworkImage(
                          url:
                              'https://cdn.pixabay.com/photo/2015/11/16/16/28/bird-1045954_1280.jpg'),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        '100K Views',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                              color: const Color.fromARGB(255, 119, 119, 111),
                            ),
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
