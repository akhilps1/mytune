import 'package:flutter/material.dart';
import 'package:mytune/general/serveices/number_converter.dart';
import 'package:provider/provider.dart';

import '../../../../general/serveices/constants.dart';
import '../../../../general/utils/theam/app_colors.dart';
import '../../../authentication/provider/login_provider.dart';
import '../../../product_details/provider/product_details_provider.dart';
import '../../../product_details/screens/product_details_page.dart';
import '../../../sheared/custom_catched_network_image.dart';
import '../../models/product_model.dart';
import '../../provider/home_screen_provider.dart';
import '../../provider/local_db_data_provider.dart';

class TopThreeThisWeek extends StatelessWidget {
  const TopThreeThisWeek({
    super.key,
    required this.size,
    required this.topThreeRelease,
  });

  final Size size;

  final List<ProductModel> topThreeRelease;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Consumer4<HomeScreenProvider, LoginProvider,
          ProductDetailsProvider, LocalDbDataProvider>(
        builder: (context, state, state2, state3, state4, _) => Column(
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
            kSizedBoxH5,
            SizedBox(
              height: size.height * 0.18,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topThreeRelease.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final product = topThreeRelease[index];
                  return InkWell(
                    onTap: () async {
                      state3.clear();
                      if (state2.isLoggdIn) {
                        if (state4.likedVideos.contains(product.id)) {
                          // print('worked if top 3');
                        } else {
                          // print('worked else top 3');
                          await state4.checkLiked(
                            product: product,
                            userId: state2.appUser!.id!,
                          );
                        }
                      }
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsPage(
                            product: product,
                            title: 'Top 3 This Week',
                          ),
                        ),
                      );
                    },
                    child: Container(
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child:
                                CustomCachedNetworkImage(url: product.imageUrl),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              '${NumberFormatter.format(value: product.views)} Views',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11,
                                    color: const Color.fromARGB(
                                        255, 119, 119, 111),
                                  ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
