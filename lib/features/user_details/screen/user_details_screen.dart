import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:iconly/iconly.dart';
import 'package:mytune/features/sheared/custom_catched_network_image.dart';
import 'package:mytune/features/user_details/provider/user_details_provider.dart';
import 'package:mytune/features/user_details/screen/widgets/custom_button.dart';
import 'package:mytune/features/user_details/screen/widgets/custom_text_field.dart';
import 'package:mytune/general/serveices/compress_image.dart';
import 'package:mytune/general/serveices/constants.dart';
import 'package:mytune/general/serveices/custom_pop_up.dart';
import 'package:mytune/general/serveices/custom_toast.dart';
import 'package:mytune/general/serveices/imag_picker_serveice.dart';
import 'package:mytune/general/utils/theam/app_colors.dart';
import 'package:provider/provider.dart';

import '../../authentication/models/user_model.dart';
import 'widgets/image_picker_widget.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({
    super.key,
    required this.appUser,
  });

  final AppUser appUser;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  bool canGoBack = false;
  AppUser? appUser;
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController hobbiesController = TextEditingController();
  TextEditingController favorateSingerController = TextEditingController();

  String? selectedImagePath;

  Uint8List? image;

  String? imgUrl;

  @override
  void initState() {
    appUser = Provider.of<UserDetailsProvider>(context, listen: false).appUser;
    phoneController.text = widget.appUser.mobileNumber;
    nameController.text = appUser?.userName ?? '';
    ageController.text = appUser?.age ?? '';
    emailController.text = appUser?.email ?? '';
    hobbiesController.text = appUser?.hobbies.toString() ?? '';
    favorateSingerController.text = appUser?.favorateSinger ?? '';

    super.initState();
  }

  @override
  void didChangeDependencies() async {
    appUser = Provider.of<UserDetailsProvider>(context).appUser;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        if (appUser!.age.isEmpty ||
            appUser!.email.isEmpty ||
            appUser!.city.isEmpty ||
            appUser!.userName.isEmpty) {
          CustomPopup.showPopup(
              context: context,
              title: 'Do you want to exit!',
              content: '',
              buttonText: 'Yes',
              size: size,
              onPressed: (ctx) async {
                exit(0);
              });
        } else {
          setState(() {
            canGoBack = true;
          });
          print(appUser.toString());
          return true;
        }

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Profile',
            style: TextStyle(fontFamily: 'poppins'),
          ),
          elevation: 3,
          shadowColor: Colors.black,
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(
            left: 25,
            right: 25,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                kSizedBoxH20,
                Center(
                  child: SizedBox(
                    width: size.width * 0.3,
                    height: size.width * 0.3,
                    child: Card(
                      surfaceTintColor: Colors.white,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Stack(
                        children: [
                          InkWell(
                            splashFactory: NoSplash.splashFactory,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              selectImage(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              width: size.width * 0.29,
                              height: size.width * 0.29,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.blueShade.withOpacity(0.1)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: appUser != null &&
                                        appUser!.imageUrl.isNotEmpty
                                    ? const CustomCachedNetworkImage(
                                        url:
                                            'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=870&q=80',
                                      )
                                    : selectedImagePath == null
                                        ? Icon(
                                            IconlyBold.profile,
                                            size: 45,
                                            color: AppColor.blueShade
                                                .withOpacity(0.4),
                                          )
                                        : Container(
                                            width: size.width * 0.29,
                                            height: size.width * 0.29,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColor.blueShade
                                                    .withOpacity(0.1)),
                                            child: Image.file(
                                              File(selectedImagePath!),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: 33,
                              width: 33,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 0.1,
                                      spreadRadius: 0.1,
                                      offset: const Offset(0.5, 0.5))
                                ],
                              ),
                              child: const Icon(
                                Icons.add_a_photo_sharp,
                                color: Color.fromARGB(155, 42, 169, 233),
                                // size: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                kSizedBoxH40,
                CustomTextField(
                  iconData: Icons.phone_android,
                  hint: 'Phone No',
                  enabled: false,
                  textEditingController: phoneController,
                ),
                kSizedBoxH15,
                CustomTextField(
                  iconData: Icons.person_2_outlined,
                  hint: 'Name',
                  textEditingController: nameController,
                ),
                kSizedBoxH15,
                CustomTextField(
                  iconData: Icons.email_outlined,
                  hint: 'Email',
                  textEditingController: emailController,
                  textInputType: TextInputType.emailAddress,
                ),
                kSizedBoxH15,
                CustomTextField(
                  iconData: Icons.numbers_outlined,
                  hint: 'Age',
                  textInputType: TextInputType.number,
                  textEditingController: ageController,
                ),
                kSizedBoxH15,
                CustomTextField(
                  iconData: Icons.location_on_outlined,
                  hint: 'Place',
                  textEditingController: placeController,
                ),
                kSizedBoxH15,
                CustomTextField(
                  iconData: Icons.sports_esports_outlined,
                  hint: 'Hobbies',
                  textEditingController: hobbiesController,
                ),
                kSizedBoxH15,
                CustomTextField(
                  iconData: Icons.record_voice_over_outlined,
                  hint: 'Favorate Singer',
                  textEditingController: favorateSingerController,
                  textInputAction: TextInputAction.done,
                ),
                kSizedBoxH15,
                SizedBox(
                  width: size.width - 50,
                  child: CustomButton(
                    onPressed: () async {
                      if (nameController.text.isEmpty) {
                        CustomToast.errorToast('Name is required');
                        return;
                      }
                      if (emailController.text.isEmpty ||
                          !emailController.text.contains('@')) {
                        CustomToast.errorToast('Email is required');
                        return;
                      }
                      if (ageController.text.isEmpty) {
                        CustomToast.errorToast('Age is required');
                        return;
                      }
                      if (phoneController.text.isEmpty) {
                        CustomToast.errorToast('Place is required');
                        return;
                      }
                      if (image != null) {
                        // ignore: use_build_context_synchronously
                        imgUrl = await Provider.of<UserDetailsProvider>(context,
                                listen: false)
                            .uploadImage(bytesImage: image!);
                      }
                      // ignore: use_build_context_synchronously
                      await Provider.of<UserDetailsProvider>(context,
                              listen: false)
                          .updateUserDetails(
                        id: appUser?.id ?? widget.appUser.id!,
                        mobileNumber: widget.appUser.mobileNumber,
                        name: nameController.text,
                        email: emailController.text,
                        age: ageController.text,
                        city: placeController.text,
                        hobbies: hobbiesController.text,
                        favorateSinger: favorateSingerController.text,
                        imageUrl: imgUrl,
                      );
                    },
                    text: 'Update',
                  ),
                ),
                kSizedBoxH20,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future selectImage(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            surfaceTintColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: ImagePickerWidet(onGalleryClicked: () async {
              Navigator.pop(context);
              selectedImagePath =
                  await ImagePickerServeice.selectImageFromGallery();

              if (selectedImagePath != null) {
                image = await compressImage(File(selectedImagePath!));
                setState(() {});
              }

              if (selectedImagePath != '') {
                // ignore: use_build_context_synchronously
              } else {
                CustomToast.errorToast('Image not selected');
              }
            }, onCameraClicked: () async {
              selectedImagePath =
                  await ImagePickerServeice.selectImageFromCamera();
              if (selectedImagePath != null) {
                image = await compressImage(File(selectedImagePath!));
                setState(() {});
                // ignore: use_build_context_synchronously
              }

              if (selectedImagePath != '') {
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              } else {
                CustomToast.errorToast('Image not captured');
              }
            }),
          );
        });
  }
}