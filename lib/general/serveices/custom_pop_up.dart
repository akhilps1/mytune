import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPopup {
  static void showPopup({
    required BuildContext context,
    required String title,
    required String content,
    required String buttonText,
    required Function(BuildContext) onPressed,
    required Size size,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: ((ctx) {
        return SizedBox(
          height: size.height * 0.3,
          child: CupertinoAlertDialog(
            title: Text(
              title,
              style: Theme.of(ctx).textTheme.titleMedium!.copyWith(
                    color: Colors.black,
                  ),
            ),
            content: Text(
              content,
              style: Theme.of(ctx).textTheme.titleMedium,
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text(
                  'No',
                  style: TextStyle(fontFamily: 'poppins'),
                ),
              ),
              CupertinoDialogAction(
                onPressed: () {
                  onPressed.call(ctx);
                },
                child: Text(
                  buttonText,
                  style: const TextStyle(fontFamily: 'poppins'),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  static void showCircularProgressIndicator(context, String? title) {
    final key = GlobalKey();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: SimpleDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              key: key,
              children: <Widget>[
                Center(
                  child: SizedBox(
                    height: 60,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          const CircularProgressIndicator(),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            title ?? "Please Wait...",
                            style: const TextStyle(
                              fontFamily: "poppins",
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ]),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
