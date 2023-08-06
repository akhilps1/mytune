// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class ImagePickerWidet extends StatelessWidget {
  const ImagePickerWidet({
    Key? key,
    required this.onCameraClicked,
    required this.onGalleryClicked,
  }) : super(key: key);

  final VoidCallback onCameraClicked;
  final VoidCallback onGalleryClicked;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select Image From !',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 20,
                    color: Colors.black87,
                  ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: onGalleryClicked,
                  child: const SizedBox(
                    height: 70,
                    width: 100,
                    child: Card(
                        elevation: 3,
                        surfaceTintColor: Colors.white,
                        child: Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(
                              IconlyBold.image_2,
                              color: Color.fromARGB(255, 81, 81, 81),
                              size: 40,
                            ))),
                  ),
                ),
                GestureDetector(
                  onTap: onCameraClicked,
                  child: const SizedBox(
                    height: 70,
                    width: 100,
                    child: Card(
                      elevation: 3,
                      surfaceTintColor: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.camera,
                          color: Color.fromARGB(255, 81, 81, 81),
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
