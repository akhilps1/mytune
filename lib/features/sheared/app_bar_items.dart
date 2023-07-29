import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytune/features/authentication/provider/login_provider.dart';
import 'package:mytune/features/authentication/screens/login_screen.dart';
import 'package:mytune/general/utils/theam/app_colors.dart';
import 'package:provider/provider.dart';

import 'custom_catched_network_image.dart';

class AppBarItems extends StatelessWidget {
  const AppBarItems({
    super.key,
    required this.size,
    required this.drowerButtonClicked,
    required this.title,
  });

  final Size size;
  final VoidCallback drowerButtonClicked;
  final String title;

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      centerTitle: false,
      background: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            Positioned(
              top: size.height * 0.06,
              child: IconButton(
                onPressed: drowerButtonClicked,
                style: const ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    minimumSize: MaterialStatePropertyAll(
                      Size(30, 30),
                    ),
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.zero,
                    )),
                icon: const Icon(
                  Icons.short_text,
                  size: 35,
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.08,
              right: 0,
              child: InkWell(
                onTap: () {
                  if (Provider.of<LoginProvider>(
                        context,
                        listen: false,
                      ).isLoggdIn ==
                      false) {
                    showModalBottomSheet(
                      // enableDrag: true,
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => Padding(
                        padding: MediaQuery.of(context).viewInsets,
                        child: const LoginScreen(),
                      ),
                    );
                  }
                },
                child: const SizedBox(
                  height: 45,
                  width: 45,
                  child: ClipRRect(
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
            ),
            Positioned(
              top: size.height * 0.12,
              left: 5,
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.black87,
                    ),
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: SizedBox(
            //     width: size.width - 20,
            //     child: Padding(
            //       padding: const EdgeInsets.only(bottom: 10),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //         children: [
            //           Container(
            //             // height: 45,
            //             width: size.width - 95,
            //             padding: const EdgeInsets.symmetric(horizontal: 15),
            //             decoration: const BoxDecoration(
            //               borderRadius: BorderRadius.all(
            //                 Radius.circular(
            //                   14,
            //                 ),
            //               ),
            //               gradient: RadialGradient(
            //                   stops: [
            //                     -1,
            //                     2,
            //                   ],
            //                   focalRadius: 1,
            //                   radius: 25,
            //                   colors: [
            //                     Colors.white,
            //                     Colors.blue,
            //                   ]),
            //             ),
            //             child: TextFormField(
            //               decoration: InputDecoration(
            //                 contentPadding: EdgeInsets.zero,
            //                 icon: const Icon(Icons.search),
            //                 hintText: 'Search for songs',
            //                 hintStyle: Theme.of(context).textTheme.titleMedium,
            //                 border: InputBorder.none,
            //               ),
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(left: 5),
            //             child: Container(
            //               height: 45,
            //               width: 43,
            //               decoration: BoxDecoration(
            //                 color: AppColor.redColor,
            //                 borderRadius: const BorderRadius.all(
            //                   Radius.circular(10),
            //                 ),
            //               ),
            //               child: IconButton(
            //                 onPressed: () {},
            //                 icon: const Icon(
            //                   Icons.keyboard_voice_outlined,
            //                   color: Colors.white,
            //                 ),
            //               ),
            //             ),
            //           )
            //         ],
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
      //Text
      //Images.network
    );
  }
}
