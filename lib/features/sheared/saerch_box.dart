import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../general/utils/theam/app_colors.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // height: 45,
            width: size.width - 95,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  14,
                ),
              ),
              gradient: RadialGradient(
                  stops: [
                    -1,
                    2,
                  ],
                  focalRadius: 1,
                  radius: 25,
                  colors: [
                    Colors.white,
                    Colors.blue,
                  ]),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                icon: const Icon(Icons.search),
                hintText: 'Search for songs',
                hintStyle: Theme.of(context).textTheme.titleMedium,
                border: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Container(
              height: 45,
              width: 43,
              decoration: BoxDecoration(
                color: AppColor.redColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.keyboard_voice_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
