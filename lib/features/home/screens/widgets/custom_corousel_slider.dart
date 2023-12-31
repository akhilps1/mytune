import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mytune/features/home/models/banner_model.dart';
import 'package:mytune/features/sheared/custom_catched_network_image.dart';
import 'package:mytune/general/utils/theam/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomCorouselSlider extends StatefulWidget {
  const CustomCorouselSlider({
    super.key,
    required this.size,
    required this.banners,
  });

  final Size size;
  final List<BannerModel> banners;

  @override
  State<CustomCorouselSlider> createState() => _CustomCorouselSliderState();
}

class _CustomCorouselSliderState extends State<CustomCorouselSlider> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.banners.length,
          itemBuilder: (ctx, index, _) {
            final banner = widget.banners[index];
            return InkWell(
              onTap: () {
                launchUrl(Uri.parse(banner.videoUrl));
              },
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 22, vertical: 8),
                      decoration: const BoxDecoration(
                          // color: Colors.blue,
                          // borderRadius: BorderRadius.all(
                          //   Radius.circular(15),
                          // ),
                          ),
                      // height: 100,
                      width: double.infinity,

                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        child: CustomCachedNetworkImage(
                          url: banner.imageUrl,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                page = index;
              });
            },
            viewportFraction: 0.9999999,
            aspectRatio: 11 / 6,
            autoPlay: true,
          ),
        ),
        SizedBox(
          child: AnimatedSmoothIndicator(
            activeIndex: page,
            count: widget.banners.length,
            axisDirection: Axis.horizontal,
            effect: WormEffect(
              activeDotColor: AppColor.redColor,
              dotColor: Colors.grey.withOpacity(0.5),
              dotWidth: 10,
              dotHeight: 10,
            ),
          ),
        ),
      ],
    );
  }
}
