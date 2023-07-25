import 'package:flutter/material.dart';
import 'package:mytune/general/utils/theam/app_colors.dart';
import 'package:pinput/pinput.dart';

class AppTheam {
  static get lightTheam => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.light,
          seedColor: AppColor.primaryColor,
          error: AppColor.redColor,
        ),
        scaffoldBackgroundColor: AppColor.bgWhiteColor,
        elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
          textStyle: MaterialStatePropertyAll(
            TextStyle(
              color: AppColor.bgWhiteColor,
            ),
          ),
          backgroundColor: MaterialStatePropertyAll(AppColor.blueShade),
        )),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(
              fontFamily: 'Poppins',
              color: AppColor.bgWhiteColor,
            ),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minimumSize: const Size(70, 15),
            padding: const EdgeInsets.all(0),
            foregroundColor: Colors.black,
          ),
        ),
        // primaryTextTheme: ,
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: AppColor.textColor,
            fontWeight: FontWeight.w700,
            fontFamily: 'Poppins',
          ),
          titleMedium: TextStyle(
              color: AppColor.textColor,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500),
          titleSmall: TextStyle(
            color: AppColor.textColor,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(
            color: AppColor.textColor,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
          hintStyle: TextStyle(
            color: AppColor.textColor,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
          helperStyle: TextStyle(
            color: AppColor.textColor,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
          errorStyle: TextStyle(
            color: AppColor.textColor,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
          ),
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            gapPadding: 0,
          ),
          errorBorder: OutlineInputBorder(
            gapPadding: 0,
            borderSide: BorderSide(
              color: AppColor.redColor,
            ),
          ),
        ),
        useMaterial3: true,
      );

  // static get darkTheam => ThemeData(
  //       colorScheme: ColorScheme.fromSeed(
  //         brightness: Brightness.dark,
  //         seedColor: Colors.blue,
  //         error: AppColor.redColor,
  //       ),
  //       elevatedButtonTheme: const ElevatedButtonThemeData(
  //           style: ButtonStyle(
  //         textStyle: MaterialStatePropertyAll(
  //           TextStyle(
  //             color: Colors.white,
  //           ),
  //         ),
  //         backgroundColor: MaterialStatePropertyAll(
  //           Color.fromARGB(157, 170, 230, 255),
  //         ),
  //       )),
  //       textButtonTheme: TextButtonThemeData(
  //         style: TextButton.styleFrom(
  //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //           minimumSize: const Size(70, 15),
  //           padding: const EdgeInsets.all(0),
  //           foregroundColor: Colors.blue,
  //         ),
  //       ),
  //       useMaterial3: true,
  //     );

  static get defaultPinTheme => PinTheme(
        width: 56,
        height: 56,
        textStyle: const TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(30, 60, 87, 1),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color.fromARGB(157, 101, 209, 255),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      );

  static get focusedPinTheme => defaultPinTheme.copyDecorationWith(
        border: Border.all(
          color: const Color.fromARGB(157, 101, 209, 255),
        ),
        borderRadius: BorderRadius.circular(8),
      );

  static get submittedPinTheme => defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration.copyWith(
          color: const Color.fromRGBO(234, 239, 243, 1),
        ),
      );
}
