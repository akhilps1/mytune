import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mytune/features/sheared/custom_catched_network_image.dart';
import 'package:mytune/general/utils/theam/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomCorouselSlider extends StatefulWidget {
  const CustomCorouselSlider({
    super.key,
    required this.size,
  });

  final Size size;

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
          itemCount: 5,
          itemBuilder: (ctx, index, _) => Column(
            children: [
              Expanded(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                  decoration: const BoxDecoration(
                    // color: Colors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  // height: 100,
                  width: double.infinity,

                  child: const ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: CustomCachedNetworkImage(
                      url:
                          'https://cdn.pixabay.com/photo/2016/11/14/04/45/elephant-1822636_1280.jpg',
                    ),
                  ),
                ),
              ),
            ],
          ),
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              setState(() {
                page = index;
              });
            },
            viewportFraction: 0.9999999,
            aspectRatio: 12 / 5,
            autoPlay: true,
          ),
        ),
        SizedBox(
          child: AnimatedSmoothIndicator(
            activeIndex: page,
            count: 5,
            axisDirection: Axis.horizontal,
            effect: WormEffect(
              activeDotColor: AppColor.redColor,
              dotWidth: 10,
              dotHeight: 10,
            ),
          ),
        ),
      ],
    );
  }
}
