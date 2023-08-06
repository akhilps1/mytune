// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytune/general/utils/theam/app_colors.dart';
import 'package:provider/provider.dart';

import '../../provider/user_details_provider.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final Function(UserDetailsProvider) onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDetailsProvider>(
      builder: (context, state, _) => ElevatedButton(
        onPressed: () {
          onPressed.call(state);
        },
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
        child: state.isLoading == false
            ? Text(
                text,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white,
                    ),
              )
            : const CupertinoActivityIndicator(
                color: Colors.white,
              ),
      ),
    );
  }
}
