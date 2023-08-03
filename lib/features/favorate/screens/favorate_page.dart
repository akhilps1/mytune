import 'package:flutter/material.dart';

import '../../sheared/custom_catched_network_image.dart';

class FavoratePage extends StatelessWidget {
  const FavoratePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text('Favorate'),
          pinned: true,
          elevation: 2,
          forceElevated: true,
          shadowColor: Colors.black.withOpacity(0.3),
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
        ),
        SliverPadding(
          padding: const EdgeInsets.all(12),
          sliver: SliverList.separated(
            itemCount: 10,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: Container(
                  height: 200,
                  color: Colors.grey[200],
                  child: Stack(children: [
                    const CustomCachedNetworkImage(
                        url:
                            'https://cdn.pixabay.com/photo/2016/11/14/04/45/elephant-1822636_1280.jpg'),
                    Align(
                      alignment: Alignment.center,
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          style: const ButtonStyle(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              backgroundColor:
                                  MaterialStatePropertyAll(Colors.white)),
                          onPressed: () {},
                          icon: const Icon(
                            Icons.play_circle_fill,
                            size: 40,
                            color: Colors.black87,
                          )),
                    ),
                  ]),
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
          ),
        )
      ],
    );
  }
}
