// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.color,
  });

  final VoidCallback onPressed;
  final Widget icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.4,
      child: IconButton(
        style: const ButtonStyle(
          fixedSize: MaterialStatePropertyAll(
            Size(30, 30),
          ),
          padding: MaterialStatePropertyAll(EdgeInsets.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: onPressed,
        icon: icon,
      ),
    );
  }
}
