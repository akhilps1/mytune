// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mytune/general/utils/theam/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(AppColor.blueShade),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}
