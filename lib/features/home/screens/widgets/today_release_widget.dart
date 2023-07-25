import 'package:flutter/material.dart';
import 'package:mytune/features/sheared/custom_catched_network_image.dart';
import 'package:mytune/general/serveices/constants.dart';
import 'package:mytune/general/utils/theam/app_colors.dart';

class TodayReleaseWidget extends StatelessWidget {
  const TodayReleaseWidget({
    super.key,
    required this.size,
  });
  final Size size;

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Today Release',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.pink,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          kSizedBoxH5,
          SizedBox(
            height: size.width * 0.38,
            width: size.width,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.only(right: 10),
                // height: 50,
                width: size.width * 0.5,
                decoration: BoxDecoration(
                  color: index == 0
                      ? AppColor.containerColor1
                      : index == 1
                          ? AppColor.containerColor2
                          : AppColor.containerColors3,
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
                  Positioned(
                    bottom: 3,
                    left: 5,
                    child: Text(
                      '100K Views',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                            color: const Color.fromARGB(255, 119, 119, 111),
                          ),
                    ),
                  ),
                  Positioned(
                    bottom: 3,
                    right: 5,
                    child: Text(
                      '2 Hours ago',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                            color: const Color.fromARGB(255, 119, 119, 111),
                          ),
                    ),
                  )
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
