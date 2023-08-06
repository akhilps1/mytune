import 'dart:async';

import 'package:flutter/material.dart';

import '../../app_root.dart';
// import 'package:mytune/features/authentication/provider/login_provider.dart';
// import 'package:mytune/features/user_details/provider/user_details_provider.dart';
// import 'package:provider/provider.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    wait();
    super.initState();
  }

  void wait() async {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const AppRoot()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 250,
          width: 250,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/wytune.png'),
            ),
          ),
        ),
      ),
    );
  }
}
