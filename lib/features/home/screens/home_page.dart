import 'package:flutter/material.dart';
import 'package:mytune/features/home/screens/widgets/custom_corousel_slider.dart';
import 'package:mytune/features/home/screens/widgets/today_release_widget.dart';
import 'package:mytune/features/home/screens/widgets/top_three_this_week.dart';
import 'package:mytune/general/serveices/constants.dart';

import '../../../general/utils/theam/app_colors.dart';
import '../../sheared/custom_catched_network_image.dart';
import '../../sheared/saerch_box.dart';
import 'widgets/app_bar_items.dart';
import 'widgets/category_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            snap: false,
            pinned: true,
            floating: false,
            surfaceTintColor: Colors.white,

            flexibleSpace: AppBarItems(size: size),

            bottom: PreferredSize(
              preferredSize: Size(double.infinity, size.height * 0.017),
              child: SearchBox(size: size),
            ),

            // flexibleSpace: AppBarItems(size: size), //FlexibleSpaceBar
            expandedHeight: size.height * 0.24,
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,

            //<Widget>[]
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              // height: size.height * 0.08,
              child: CustomCorouselSlider(
                size: size,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
                height: size.height * 0.25, child: CategoryWidget(size: size)),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            sliver: SliverList.separated(
              itemCount: 1,
              itemBuilder: (context, index) => SizedBox(
                // color: Colors.blue,
                height: size.height * 0.28,
                // width: size.width - 20,
                child: TodayReleaseWidget(
                  size: size,
                ),
              ),
              separatorBuilder: (context, inddex) => const SizedBox(),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
                height: size.height * 0.28,
                child: TopThreeThisWeek(size: size)),
          ),
        ],
      ),
    );
  }
}
