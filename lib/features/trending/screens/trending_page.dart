import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:mytune/features/sheared/custom_catched_network_image.dart';

class TrendingPage extends StatelessWidget {
  const TrendingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          shadowColor: Colors.black.withOpacity(0.3),
          elevation: 1,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          forceElevated: true,
          title: const Text(
            'Trending',
            style: TextStyle(
              fontFamily: 'poppins',
            ),
          ),
        ),
        SliverFillRemaining(
          child: MasonryGridView.builder(
              itemCount: 10,
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      height: index % 2 == 1 ? 250 : 300,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CustomCachedNetworkImage(
                                url: index % 2 == 0
                                    ? 'https://images.unsplash.com/photo-1628784230353-5bee16e2f005?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=435&q=80'
                                    : 'https://images.unsplash.com/photo-1633621412960-6df85eff8c85?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fGltYWdlfGVufDB8fDB8fHww&auto=format&fit=crop&w=600&q=60'),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Icon(Icons.play_arrow),
                          )
                        ],
                      ),
                    ),
                  )),
        )
      ],
    );
  }
}
