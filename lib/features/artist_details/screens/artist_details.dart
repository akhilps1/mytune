import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mytune/features/artist_details/screens/widgets/artist_profile.dart';
import 'package:mytune/features/sheared/custom_catched_network_image.dart';
import 'package:mytune/general/serveices/constants.dart';

class ArtistDetails extends StatefulWidget {
  const ArtistDetails({
    super.key,
    required this.categoryId,
  });

  final String categoryId;

  @override
  State<ArtistDetails> createState() => _ArtistDetailsState();
}

class _ArtistDetailsState extends State<ArtistDetails> {
  final ScrollController controller = ScrollController();
  @override
  void initState() {
    controller.addListener(
      () {
        if (controller.position.pixels == 200) {
          // print('worked');
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    log(widget.categoryId);
    return Scaffold(
      // appBar: AppBar(),
      body: CustomScrollView(
        controller: controller,
        slivers: [
          SliverAppBar(
            expandedHeight: size.height * 0.44,
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.keyboard_backspace,
                color: Color.fromARGB(255, 137, 156, 224),
              ),
            ),
            pinned: true,
            flexibleSpace: const FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              centerTitle: true,
              background: ArtistProfile(),
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(15),
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue,
                  ),
                  child: const Center(child: Text('126 Songs')),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(15),
            sliver: SliverList.separated(
              itemCount: 10,
              itemBuilder: (context, index) => Container(
                height: 200,
                color: Colors.blue,
                child: const CustomCachedNetworkImage(
                    url:
                        'https://firebasestorage.googleapis.com/v0/b/my-tune-admin.appspot.com/o/products%2F1690441360302000webp_image.jpeg?alt=media&token=b0ab6251-d21c-49ac-9d59-a3c005f80c68'),
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: 5,
              ),
            ),
          )
        ],
      ),
    );
  }
}
