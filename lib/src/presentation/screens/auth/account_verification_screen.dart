import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:rha/src/config/config.dart';
import 'package:rha/src/domain/domain.dart';
import 'package:rha/src/presentation/presentation.dart';
import 'package:rha/src/utils/utils.dart';

class AccountVerificationScreen extends StatefulWidget {
  final Map<String, dynamic> val;

  const AccountVerificationScreen({required this.val});

  @override
  State<AccountVerificationScreen> createState() =>
      _AccountVerificationScreenState();
}

class _AccountVerificationScreenState extends State<AccountVerificationScreen> {
  String pin = "";

  SignupController signupController = Get.find();

  TextEditingController pinController = TextEditingController();

  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // int sec = ref.read(secProvider);
      // if (sec > 0) {
      //   ref.read(secProvider.notifier).state = sec - 1;
      //
      //   if (pinController.text.length >= 6) {
      //     timer.cancel();
      //     ref.read(secProvider.notifier).state = 30;
      //     ref.read(resetOtpProvider(pinController.text).future).then((value) {
      //       log('The successful otp  ${value.data}');
      //       Navigator.pushNamed(context, AppRoutes.newPasswordScreen);
      //     }).catchError((err) {
      //       log('The error otp  $err');
      //       pinController.clear();
      //       startTimer();
      //     });
      //   }
      // } else {
      //   ref.read(secProvider.notifier).state = 30;
      //   log('Pin completed');
      //   timer.cancel();
      //   if (pinController.text.isEmpty) {
      //     log('Empty pin');
      //     startTimer();
      //   } else {
      //     ref.read(resetOtpProvider(pinController.text).future).then((value) {
      //       log('The successful otp  ${value.data}');
      //       Navigator.pushNamed(context, AppRoutes.newPasswordScreen);
      //     }).catchError((err) {
      //       log('The error otp  $err');
      //       pinController.clear();
      //       startTimer();
      //     });
      //   }
      // }
    });
  }

  @override
  void initState() {
    startTimer();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: AppColors.lightBackgroundColor,
          leading: const BackButton(
            color: AppColors.darkBackgroundColor,
          ),
          elevation: 0,
        ),
        backgroundColor: AppColors.lightBackgroundColor,
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * .02,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    widget.val['type'] == Constants.verifyScreen
                        ? 'Account verification'
                        : 'Forgot Password',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: height * .02,
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    widget.val['type'] == Constants.verifyScreen
                        ? 'Enter your OTP code sent to your email or phone number'
                        : 'Enter your OTP code',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.darkBackgroundColor.withOpacity(.4)),
                  ),
                ),
                // Container(
                //   margin: const EdgeInsets.symmetric(horizontal: 10),
                //   child: Text(
                //     widget.val['phone'],
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                SizedBox(
                  height: height * .04,
                ),
                Center(
                  child: Pinput(
                    length: 5,
                    controller: pinController,
                    onCompleted: (pin) => log(pin),
                    defaultPinTheme: PinTheme(
                      width: 56,
                      height: 56,
                      textStyle: Theme.of(context).textTheme.headlineMedium,
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey.withOpacity(
                            .4), // Set the background color to yellow
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.transparent),
                      ),
                    ),
                    focusedPinTheme: PinTheme(
                      width: 56,
                      height: 56,
                      textStyle: Theme.of(context).textTheme.headlineMedium,
                      decoration: BoxDecoration(
                        color: AppColors.tallyColor.withOpacity(
                            .2), // Keep the background yellow when focused
                        borderRadius: BorderRadius.circular(8),
                        border:
                        Border.all(color: AppColors.tallyColor, width: 1),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .02,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: RichText(
                      text: TextSpan(
                          text: "Didn’t receive code? ",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.w500),
                          children: [
                        TextSpan(
                            text: "Resend again",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.tallyColor)),
                      ])),
                ),
                SizedBox(
                  height: height * .2,
                ),
                AppButton(
                    buttonRadius: 10,
                    pressedFunction: widget.val['type'] ==
                        Constants.verifyScreen
                        ? () async {
                      if (pinController.text == '' ||
                          widget.val['email'] == '') {
                        UtilFunctions.showTopSnackError(
                            context, 'Please input OTP');
                        return;
                      }
                      UtilFunctions.showOverLay(context);

                      signupController.emailSignupController.text =
                      widget.val['email'];

                      VerifyOtpDto verifyOtpDto = VerifyOtpDto(
                          email: widget.val['email'],
                          otp: pinController.text);
                      ResponseModel responseModel =
                      await signupController.verifyOtp(verifyOtpDto);

                      if (context.mounted) {
                        UtilFunctions.hideOverLay(context);
                        if (responseModel.isError) {
                          UtilFunctions.showTopSnackError(
                              context, responseModel.data);
                        } else {
                          Get.toNamed(AppRoutes.login);
                        }
                      }
                    }
                        : () async {
                      if (pinController.text == '' ||
                          widget.val['email'] == '') {
                        UtilFunctions.showTopSnackError(
                            context, 'Please input OTP');
                        return;
                      }
                      UtilFunctions.showOverLay(context);

                      signupController.emailSignupController.text =
                      widget.val['email'];

                      VerifyOtpDto verifyOtpDto = VerifyOtpDto(
                          email: widget.val['email'],
                          otp: pinController.text);
                      ResponseModel responseModel =
                      await signupController.verifyOtp(verifyOtpDto);

                      if (context.mounted) {
                        UtilFunctions.hideOverLay(context);
                        if (responseModel.isError) {
                          UtilFunctions.showTopSnackError(
                              context, responseModel.data);
                        } else {
                          signupController.otp.value = pinController.text;

                          Get.toNamed(AppRoutes.newPassword);
                        }
                      }
                    },
                    buttonColor: AppColors.tallyColor,
                    buttonText: 'Verify'),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ));
  }
}
