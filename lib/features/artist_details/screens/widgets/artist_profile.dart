import 'package:flutter/material.dart';
import 'package:mytune/features/sheared/custom_catched_network_image.dart';

class ArtistProfile extends StatelessWidget {
  const ArtistProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.47,
      color: const Color.fromARGB(255, 247, 252, 255),
      padding: const EdgeInsets.only(bottom: 15),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 190,
            right: 180,
            child: Container(
              height: 250,
              width: 250,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 137, 156, 224),
                  borderRadius: BorderRadius.all(Radius.circular(100))),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: 240,
              width: 200,
              color: const Color.fromARGB(255, 255, 175, 162),
            ),
          ),
          Positioned(
            bottom: 200,
            left: 178,
            child: Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 175, 162),
                  borderRadius: BorderRadius.all(Radius.circular(100))),
            ),
          ),
          SizedBox(
            width: size.width * 0.9,
            height: size.height * 0.3,
            child: Card(
              elevation: 1,
              surfaceTintColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Laura Sam',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(255, 69, 68, 65),
                          fontSize: 20,
                          letterSpacing: 1.1,
                        ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              '200K',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: const Color.fromARGB(
                                        255, 108, 149, 168),
                                    fontSize: 20,
                                    letterSpacing: 1.2,
                                  ),
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromARGB(
                                          255, 183, 183, 182),
                                      fontSize: 15,
                                      letterSpacing: 1.2),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              '500K',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: const Color.fromARGB(
                                          255, 108, 149, 168),
                                      fontSize: 20,
                                      letterSpacing: 1.2),
                            ),
                            const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: size.width * 0.6,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Follow',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 18,
                                letterSpacing: 1.2),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.093,
            child: SizedBox(
              width: size.width * 0.25,
              height: size.width * 0.25,
              child: Card(
                // color: Colors.amber,
                surfaceTintColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: const CustomCachedNetworkImage(
                        url:
                            'https://firebasestorage.googleapis.com/v0/b/my-tune-admin.appspot.com/o/categories%2F1690440540905000webp_image.jpeg?alt=media&token=0b859124-16b1-418a-a159-998f4b3cdca8'),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 15,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.keyboard_backspace,
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          )
        ],
      ),
    );
  }
}

// class CustomHalfCircleClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     final Path path = Path();
//     path.lineTo(0.0, size.height / 2);
//     path.lineTo(size.width, size.height / 2);
//     path.lineTo(size.width, 0);
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return true;
//   }
// }
