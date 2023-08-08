import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../sheared/custom_catched_network_image.dart';

class FavoratePage extends StatelessWidget {
  const FavoratePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[200],
                  ),
                  child: Stack(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: const CustomCachedNetworkImage(
                          url:
                              'https://firebasestorage.googleapis.com/v0/b/my-tune-admin.appspot.com/o/categories%2F1690440709157000webp_image.jpeg?alt=media&token=174dde5b-ec0e-42fc-90cd-8a7c459a7a2b'),
                    ),
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
                    Positioned(
                      bottom: 5,
                      left: 5,
                      right: 5,
                      child: Container(
                        height: 45,
                        width: size.width - 30,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Daily Daily Video Song | Dabzee | Anarkali | Jahaan | Chemban Vinod Jose | Lukman Avaran.',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ),
                    )
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
