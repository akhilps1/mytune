import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:mytune/features/sheared/custom_catched_network_image.dart';
import 'package:mytune/general/serveices/constants.dart';

import 'package:mytune/general/utils/theam/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../general/serveices/custom_pop_up.dart';
import '../../authentication/provider/login_provider.dart';
import 'widgets/profile_item.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverAppBar(
              title: Text(
                'Account',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 20,
                      color: Colors.black,
                    ),
              ),

              shadowColor: Colors.transparent,
              pinned: true,
              // expandedHeight: size.height * 0.16,
              elevation: 1,

              backgroundColor: AppColor.containerColor2,
              surfaceTintColor: AppColor.containerColor2,
              bottom: PreferredSize(
                preferredSize: Size(size.width, size.height * 0.16),
                child: Container(
                  width: double.infinity,
                  height: size.height * 0.17,
                  decoration: const BoxDecoration(),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          height: size.width * 0.25,
                          width: size.width * 0.25,
                          child: Card(
                            elevation: 1,
                            surfaceTintColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: true == false
                                    ? const CustomCachedNetworkImage(
                                        url:
                                            'https://cdn.pixabay.com/photo/2023/06/27/10/51/man-8091933_1280.jpg',
                                      )
                                    : Container(
                                        color: const Color.fromARGB(
                                                255, 180, 180, 180)
                                            .withOpacity(0.09),
                                        child: const Center(
                                          child: Icon(
                                            IconlyLight.profile,
                                            size: 40,
                                            color: Color.fromARGB(
                                                255, 188, 208, 224),
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: size.width * 0.63,
                        height: size.width * 0.26,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              onPressed: () {},
                              child: Text(
                                'Sign up',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                            kSizedBoxH5,
                            Text(
                              'View and update your profile details',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: Colors.black54,
                                    fontSize: 10,
                                  ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  ProfileItemCard(
                      title: "Notification",
                      icon: const Icon(
                        IconlyLight.notification,
                        color: AppColor.textColor,
                        size: 30,
                      ),
                      onTap: () {}),
                  ProfileItemCard(
                      title: "Help Center",
                      icon: const Icon(
                        Icons.support_agent,
                        color: AppColor.textColor,
                        size: 30,
                      ),
                      onTap: () {}),
                  ProfileItemCard(
                      title: "Invite Friends",
                      icon: const Icon(
                        Icons.share_outlined,
                        color: AppColor.textColor,
                        size: 30,
                      ),
                      onTap: () {}),
                  ProfileItemCard(
                      title: "Rate MyTune",
                      icon: const Icon(
                        Icons.star_half_outlined,
                        color: AppColor.textColor,
                        size: 30,
                      ),
                      onTap: () {}),
                  ProfileItemCard(
                      title: "Privacy Policy",
                      icon: const Icon(
                        Icons.privacy_tip_outlined,
                        color: AppColor.textColor,
                        size: 30,
                      ),
                      onTap: () {}),
                  ProfileItemCard(
                      title: "Logout",
                      icon: const Icon(
                        Icons.logout_outlined,
                        color: AppColor.textColor,
                        size: 30,
                      ),
                      onTap: () {
                        CustomPopup.showPopup(
                          context: context,
                          title: 'Do you want to logout!',
                          content: '',
                          buttonText: 'Yes',
                          size: size,
                          onPressed: (ctx) async {
                            CustomPopup.showCircularProgressIndicator(
                                context, 'Logging out...');
                            await Provider.of<LoginProvider>(
                              context,
                              listen: false,
                            ).logOut();
                            // ignore: use_build_context_synchronously
                            Navigator.pop(ctx);
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          },
                        );
                      }),
                  ProfileItemCard(
                      title: "Delete Account",
                      icon: const Icon(
                        Icons.delete_outline,
                        color: AppColor.textColor,
                        size: 30,
                      ),
                      onTap: () {}),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      height: 100,
                      decoration: const BoxDecoration(
                          boxShadow: [BoxShadow(color: Colors.white)]),
                      child: Column(
                        children: [
                          kSizedBoxH5,
                          const CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.blue,
                          ),
                          kSizedBoxH5,
                          Text(
                            'Version: 1.0.0',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  fontSize: 15,
                                ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
