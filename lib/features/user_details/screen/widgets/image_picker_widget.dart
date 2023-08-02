// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:user/application/home/home_bloc.dart';

// Future selectImage(BuildContext context) {
//   String? selectedImagePath;
//   return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20.0)), //this right here
//           child: Container(
//             height: 200,
//             child: Padding(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'Select Image From !',
//                     style:
//                         TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       GestureDetector(
//                         onTap: () async {
//                           selectedImagePath = await selectImageFromGallery();

//                           if (selectedImagePath != '' &&
//                               selectedImagePath != 'assets/images/person.png') {
//                             // ignore: use_build_context_synchronously
//                             BlocProvider.of<HomeBloc>(context).add(
//                                 GalleryImageSelected(path: selectedImagePath!));
//                             // ignore: use_build_context_synchronously
//                             BlocProvider.of<HomeBloc>(context)
//                                 .add(ImageSelectrd(path: selectedImagePath!));
//                             // ignore: use_build_context_synchronously
//                             Navigator.pop(context);
//                           } else {
//                             // ignore: use_build_context_synchronously
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(const SnackBar(
//                               content: Text("No Image Selected !"),
//                             ));
//                           }
//                         },
//                         child: Card(
//                             elevation: 5,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 children: [
//                                   Image.asset(
//                                     'assets/images/gallery.png',
//                                     height: 60,
//                                     width: 60,
//                                   ),
//                                   const Text('Gallery'),
//                                 ],
//                               ),
//                             )),
//                       ),
//                       GestureDetector(
//                         onTap: () async {
//                           selectedImagePath = await selectImageFromCamera();

//                           if (selectedImagePath != '' &&
//                               selectedImagePath != 'assets/images/person.png') {
//                             // ignore: use_build_context_synchronously

//                             BlocProvider.of<HomeBloc>(context).add(
//                                 CameraImageSelected(path: selectedImagePath!));
//                             // ignore: use_build_context_synchronously
//                             Navigator.pop(context);
//                             // ignore: use_build_context_synchronously
//                             BlocProvider.of<HomeBloc>(context)
//                                 .add(ImageSelectrd(path: selectedImagePath!));
//                           } else {
//                             // ignore: use_build_context_synchronously
//                             ScaffoldMessenger.of(context)
//                                 .showSnackBar(const SnackBar(
//                               content: Text("No Image Captured !"),
//                             ));
//                           }
//                         },
//                         child: Card(
//                             elevation: 5,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 children: [
//                                   Image.asset(
//                                     'assets/images/camera.png',
//                                     height: 60,
//                                     width: 60,
//                                   ),
//                                   const Text('Camera'),
//                                 ],
//                               ),
//                             )),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         );
//       });
// }

// selectImageFromGallery() async {
//   XFile? file = await ImagePicker()
//       .pickImage(source: ImageSource.gallery, imageQuality: 10);
//   if (file != null) {
//     return file.path;
//   } else {
//     return '';
//   }
// }

// //
// selectImageFromCamera() async {
//   XFile? file = await ImagePicker()
//       .pickImage(source: ImageSource.camera, imageQuality: 10);
//   if (file != null) {
//     return file.path;
//   } else {
//     return '';
//   }
// }