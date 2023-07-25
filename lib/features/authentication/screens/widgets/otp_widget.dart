import 'package:flutter/material.dart';
import 'package:mytune/general/utils/theam/app_theam.dart';
import 'package:pinput/pinput.dart';

class OtpWidget extends StatelessWidget {
  const OtpWidget({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      defaultPinTheme: AppTheam.defaultPinTheme,
      focusedPinTheme: AppTheam.focusedPinTheme,
      submittedPinTheme: AppTheam.submittedPinTheme,
      // validator: (s) {
      //   return s == '2222' ? null : 'Pin is incorrect';
      // },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      autofocus: true,
      onCompleted: (pin) => controller.text = pin,
    );
  }
}
