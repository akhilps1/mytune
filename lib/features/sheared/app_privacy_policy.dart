import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AppPrivacyPolicy extends StatelessWidget {
  const AppPrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "By continuing, you agree to MyTune's",
          style: TextStyle(
            color: Color(0XFF707070),
            fontFamily: "Poppins",
            fontSize: 12,
          ),
        ),
        RichText(
          text: TextSpan(
              // text: "By continuing you agree to $appname's",
              children: [
                TextSpan(
                    text: " Terms and Conditions",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 21, 136, 230),
                      fontFamily: "Poppins",
                      fontSize: 12,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {}),
                const TextSpan(
                  text: " and ",
                  style: TextStyle(
                    color: Color(0XFF707070),
                    fontFamily: "Poppins",
                    fontSize: 12,
                  ),
                ),
                TextSpan(
                    text: "Privacy Policy",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 21, 136, 230),
                      fontFamily: "Poppins",
                      fontSize: 12,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {})
              ],
              style: const TextStyle(color: Colors.black, fontSize: 13)),
        ),
      ],
    );
  }
}
