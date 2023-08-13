// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:mytune/features/authentication/models/user_model.dart';
import 'package:mytune/features/authentication/provider/login_provider.dart';
import 'package:mytune/features/authentication/screens/login_screen.dart';

import 'package:provider/provider.dart';

import 'custom_catched_network_image.dart';

class AppBarItems extends StatefulWidget {
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
  State<AppBarItems> createState() => _AppBarItemsState();
}

class _AppBarItemsState extends State<AppBarItems> {
  bool? isLoggdIn;
  AppUser? appUser;
  @override
  void initState() {
    isLoggdIn = Provider.of<LoginProvider>(
      context,
      listen: false,
    ).isLoggdIn;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    isLoggdIn = Provider.of<LoginProvider>(
      context,
    ).isLoggdIn;

    appUser = Provider.of<LoginProvider>(
      context,
    ).appUser;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      centerTitle: false,
      background: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            Positioned(
              top: widget.size.height * 0.06,
              child: IconButton(
                onPressed: widget.drowerButtonClicked,
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
              top: widget.size.height * 0.08,
              right: 0,
              child: InkWell(
                splashFactory: NoSplash.splashFactory,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () {
                  if (isLoggdIn == false) {
                    showModalBottomSheet(
                      // enableDrag: true,
                      isScrollControlled: true,
                      context: context,
                      builder: (ctx) => Padding(
                        padding: MediaQuery.of(ctx).viewInsets,
                        child: LoginScreen(
                          ctx: ctx,
                        ),
                      ),
                    );
                  }
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => UserDetailsScreen(
                  //         // appUser: appUser,
                  //         ),
                  //   ),
                  // );
                },
                child: SizedBox(
                  height: 45,
                  width: 45,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: isLoggdIn == true &&
                            appUser != null &&
                            appUser!.imageUrl != null &&
                            appUser!.imageUrl!.isNotEmpty
                        ? CustomCachedNetworkImage(
                            url: appUser!.imageUrl!,
                          )
                        : Container(
                            color: Colors.black.withOpacity(0.2),
                            child: const Icon(
                              IconlyLight.profile,
                              color: Color.fromARGB(255, 107, 122, 134),
                            ),
                          ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: widget.size.height * 0.12,
              left: 5,
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.black87,
                    ),
              ),
            ),
          ],
        ),
      ),
      //Text
      //Images.network
    );
  }
}
