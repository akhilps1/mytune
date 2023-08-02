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
          backgroundColor: Colors.grey[200],
        ),
        SliverPadding(
          padding: const EdgeInsets.all(8),
          sliver: SliverList.separated(
            itemCount: 10,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: Container(
                  height: 200,
                  color: Colors.grey[200],
                  child: const CustomCachedNetworkImage(
                      url:
                          'https://cdn.pixabay.com/photo/2016/11/14/04/45/elephant-1822636_1280.jpg'),
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
