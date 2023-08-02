// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.iconData,
    required this.hint,
    this.suffixIcon,
    this.onChange,
    this.validater,
    this.fomeKey,
    required this.textEditingController,
    this.textInputType,
    this.textInputAction,
    this.enabled,
  }) : super(key: key);

  final GlobalKey<FormState>? fomeKey;
  final IconData? iconData;
  final String hint;
  final bool? suffixIcon;
  final Function(String)? onChange;
  final String? Function(String?)? validater;
  final TextEditingController textEditingController;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 0.1,
            spreadRadius: 0.1,
            offset: const Offset(0.5, 0.5),
          ),
        ],
        gradient: const RadialGradient(
            stops: [
              -1,
              2,
            ],
            focalRadius: 1,
            radius: 25,
            colors: [
              Colors.white,
              Colors.blue,
            ]),
      ),
      child: TextFormField(
        enabled: enabled ?? true,
        controller: textEditingController,
        keyboardType: textInputType ?? TextInputType.text,
        textInputAction: textInputAction ?? TextInputAction.next,
        onChanged: onChange,
        validator: validater,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              // color: Colors.white,
              fontSize: 16,
            ),
        decoration: InputDecoration(
          prefixIcon: Icon(iconData),
          hintText: hint,
          hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                // color: Colors.white,
                fontSize: 16,
              ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            gapPadding: 0,
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            gapPadding: 0,
          ),
        ),
      ),
    );
  }
}
