import 'dart:developer';

import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_code_picker/flutter_country_code_picker.dart';
import 'package:mytune/features/authentication/provider/country_code_picker_provider.dart';

import 'package:mytune/features/authentication/provider/login_provider.dart';
import 'package:mytune/features/authentication/screens/widgets/contry_picker.dart';
import 'package:mytune/features/sheared/app_privacy_policy.dart';
import 'package:mytune/general/serveices/custom_toast.dart';
import 'package:mytune/general/serveices/constants.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../../general/utils/theam/app_theam.dart';
import '../../sheared/custom_button_widget.dart';
import 'widgets/otp_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController controller = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer2<LoginProvider, CountryCodePickerProvider>(
      builder: (context, state, state1, _) => SizedBox(
        height: size.height * 0.37,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
          child: ListView(shrinkWrap: true, children: [
            state.otpSent == false
                ? Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Signup to continue',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.black87,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                          bottom: 20,
                        ),
                        child: Row(children: [
                          Flexible(
                            flex: 2,
                            fit: FlexFit.tight,
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 4),
                              // width: 120,
                              padding:
                                  const EdgeInsets.only(left: 0, bottom: 4),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Colors.black54),
                                ),
                              ),
                              child: const ContryPickerWidget(),
                            ),
                          ),
                          kSizedBoxW5,
                          kSizedBoxW5,
                          Expanded(
                            flex: 3,
                            child: SizedBox(
                              // width: size.width - 200,
                              child: TextFormField(
                                controller: phoneController,
                                maxLength: 10,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontSize: 16,
                                      letterSpacing: 1.2,
                                    ),
                                textInputAction: TextInputAction.done,
                                autofocus: true,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    border: const UnderlineInputBorder(),
                                    errorBorder: const UnderlineInputBorder(),
                                    label: Text(
                                      'Phone Number',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                            fontSize: 17,
                                          ),
                                    )

                                    // border: InputBorder.none,
                                    ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(
                        width: size.width - 60,
                        child: CustomButtonWidget(
                          onPressed: () async {
                            if (phoneController.text.isEmpty) {
                              CustomToast.errorToast(
                                  'Please enter a valid phone number');
                              return;
                            }
                            if (phoneController.text.length < 10) {
                              CustomToast.errorToast(
                                  'Please enter a 10 digits phone number');
                              return;
                            }
                            await state.sendOtpClicked(
                              phoneNumber:
                                  '+${state1.country.phoneCode}${phoneController.text}',
                            );
                          },
                          child: state.isLoading == false
                              ? Text(
                                  'Sent Otp',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium!.copyWith(
                                        color: Colors.white,
                                      ),
                                )
                              : const CupertinoActivityIndicator(
                                  color: Colors.white,
                                ),
                        ),
                      ),
                      kSizedBoxH20,
                      const AppPrivacyPolicy(),
                    ],
                  )
                : Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Verify Otp to continue',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Colors.black87,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 40,
                          bottom: 30,
                        ),
                        child: OtpWidget(
                          controller: controller,
                        ),
                      ),
                      SizedBox(
                        width: size.width - 60,
                        child: CustomButtonWidget(
                          onPressed: () async {
                            if (controller.text.isEmpty) {
                              CustomToast.errorToast('Enter a valid otp');
                              return;
                            }
                            if (controller.text.length < 6) {
                              CustomToast.errorToast('Enter a 6 digits otp');
                              return;
                            }
                            await state.veryfyOtpClicked(
                              otp: controller.text,
                            );
                          },
                          child: Text(
                            'Verify Otp',
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      ),
                    ],
                  )
          ]),
        ),
      ),
    );
  }
}