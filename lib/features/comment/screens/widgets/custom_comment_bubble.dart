import 'dart:math' as math; // import this

import 'package:flutter/material.dart';

import 'traiagle_widget.dart';

class ReceivedMessage extends StatelessWidget {
  final String message;
  const ReceivedMessage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 10,
        left: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 30),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.rotationY(math.pi),
                  child: CustomPaint(
                    painter: Triangle(Colors.grey[100]!),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 14,
                      bottom: 14,
                      top: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                    ),
                    child: Text(
                      message,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
