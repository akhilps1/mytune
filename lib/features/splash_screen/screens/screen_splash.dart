import 'package:flutter/material.dart';
import 'package:mytune/features/authentication/provider/login_provider.dart';
import 'package:mytune/features/user_details/provider/user_details_provider.dart';
import 'package:provider/provider.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    final user =
        Provider.of<LoginProvider>(context, listen: false).checkLoginStatus();
    if (user != null) {
      Provider.of<UserDetailsProvider>(context, listen: false)
          .getUserDetails(userId: user.uid);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
