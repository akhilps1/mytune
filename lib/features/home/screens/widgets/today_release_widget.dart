import 'package:flutter/material.dart';
import 'package:mytune/features/sheared/custom_catched_network_image.dart';
import 'package:mytune/general/serveices/constants.dart';
import 'package:mytune/general/serveices/number_converter.dart';
import 'package:mytune/general/serveices/time_converter.dart';
import 'package:mytune/general/utils/theam/app_colors.dart';

import '../../../product_details/screens/product_details_page.dart';
import '../../models/product_model.dart';

class TodayReleaseWidget extends StatelessWidget {
  const TodayReleaseWidget({
    super.key,
    required this.size,
    required this.todayRelease,
  });
  final Size size;
  final List<ProductModel> todayRelease;

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
              itemCount: todayRelease.length,
              itemBuilder: (context, index) {
                final product = todayRelease[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailsPage(
                          product: product,
                          title: 'Today Release',
                        ),
                      ),
                    );
                  },
                  child: Container(
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: CustomCachedNetworkImage(url: product.imageUrl),
                      ),
                      Positioned(
                        bottom: 3,
                        left: 5,
                        child: Text(
                          '${NumberFormatter.format(value: product.views)} Views',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
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
                          postedDateTime(product.timestamp.toDate()),
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                                color: const Color.fromARGB(255, 119, 119, 111),
                              ),
                        ),
                      )
                    ]),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
