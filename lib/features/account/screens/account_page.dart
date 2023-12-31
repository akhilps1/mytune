import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import 'package:mytune/features/home/provider/local_db_data_provider.dart';
import 'package:mytune/features/sheared/custom_catched_network_image.dart';
import 'package:mytune/features/user_details/screen/user_details_screen.dart';
import 'package:mytune/general/serveices/constants.dart';
import 'package:mytune/general/serveices/custom_toast.dart';

import 'package:mytune/general/utils/theam/app_colors.dart';
import 'package:provider/provider.dart';

import '../../../general/serveices/custom_pop_up.dart';
import '../../authentication/provider/login_provider.dart';
import '../../authentication/screens/login_screen.dart';
import 'widgets/profile_item.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  // @override
  // void didChangeDependencies() async {
  //   if (Provider.of<LoginProvider>(context).isLoading == true &&
  //       Provider.of<LoginProvider>(context).appUser != null &&
  //       Provider.of<LoginProvider>(context).appUser!.userName == null) {
  //     // ignore: use_build_context_synchronously

  //   }
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Colors.grey[200],
        child: Consumer2<LoginProvider, LocalDbDataProvider>(
          builder: (context, state, state2, _) => CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverAppBar(
                title: Text(
                  'Account',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                ),

                shadowColor: Colors.transparent,
                pinned: true,
                // expandedHeight: size.height * 0.16,
                elevation: 1,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color.fromARGB(255, 119, 102, 179),
                            Color.fromARGB(255, 143, 159, 216),
                            Color.fromARGB(255, 158, 204, 223),
                          ]),
                    ),
                  ),
                ),
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
                                  child: state.isLoggdIn == true &&
                                          state.appUser != null &&
                                          state.appUser!.imageUrl != null &&
                                          state.appUser!.imageUrl!.isNotEmpty
                                      ? CustomCachedNetworkImage(
                                          url: state.appUser!.imageUrl!,
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
                          child: Consumer<LoginProvider>(
                            builder: (context, state, _) => state.isLoggdIn ==
                                    false
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          if (state.isLoggdIn == false) {
                                            showModalBottomSheet(
                                              // enableDrag: true,

                                              isScrollControlled: true,
                                              context: context,
                                              builder: (ctx) => Padding(
                                                padding: MediaQuery.of(ctx)
                                                    .viewInsets,
                                                child: LoginScreen(
                                                  ctx: ctx,
                                                ),
                                              ),
                                            );
                                          }
                                        },
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
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                      )
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        state.appUser != null &&
                                                state.appUser!.userName !=
                                                    null &&
                                                state.appUser!.userName!
                                                    .isNotEmpty
                                            ? state.appUser!.userName!
                                            : state.appUser!.mobileNumber ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UserDetailsScreen(
                                                appUser: state.appUser!,
                                              ),
                                            ),
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 20,
                                          color: Colors.white,
                                          weight: 10,
                                        ),
                                      )
                                    ],
                                  ),
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
                    // ProfileItemCard(
                    //     title: "Notification",
                    //     icon: const Icon(
                    //       IconlyLight.notification,
                    //       color: AppColor.textColor,
                    //       size: 30,
                    //     ),
                    //     onTap: () {}),

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
                              if (state.isLoggdIn == true) {
                                Navigator.pop(context);
                                CustomPopup.showCircularProgressIndicator(
                                    context, 'Logging out...');
                                await Provider.of<LoginProvider>(
                                  context,
                                  listen: false,
                                ).logOut();
                                // ignore: use_build_context_synchronously
                                Navigator.pop(ctx);
                                // ignore: use_build_context_synchronously
                              } else {
                                CustomToast.errorToast('Please login first');

                                Navigator.pop(context);
                              }
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
                        onTap: () {
                          CustomPopup.showPopup(
                            context: context,
                            title: 'Doyou want to delete your account',
                            content: '',
                            buttonText: 'yes',
                            onPressed: (value) async {
                              await state.deleteAccount();
                              state2.deleteAllData();
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            },
                            size: size,
                          );
                        }),
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
                              backgroundImage:
                                  AssetImage('assets/images/wytune.png'),
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
      ),
    );
  }
}
