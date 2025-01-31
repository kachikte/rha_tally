import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rha/src/config/config.dart';
import 'package:rha/src/presentation/presentation.dart';
import 'package:rha/src/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;


    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.lightBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * .1,
            ),
            Container(
              width: width,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Welcome Back",
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            SizedBox(
              height: height * .025,
            ),
            AppInput(
                textEditingController: loginController.usernameController,
                hintText: "Email/Phone Number",
                icon: const Icon(Icons.mail),
                errorText: "Please enter your Email/Phone Number",
                width: width,
                label: "",
                height: height),
            Obx(() => AppInput(
                textEditingController: loginController.passwordController,
                icon: const Icon(Icons.password),
                suffixIcon: GestureDetector(
                  onTap: () {
                    log('trying to change the obscure = ${loginController.isObscure.value}');
                    loginController.isObscure.value =
                    !loginController.isObscure.value;
                  },
                  child: loginController.isObscure.value
                      ? const Icon(Icons.remove_red_eye)
                      : const Icon(Icons.remove_red_eye_outlined),
                ),
                type: Constants.passwordFieldType,
                pinObscure: loginController.isObscure.value,
                // icon: Image.asset(AppImages.tallyLogo),
                hintText: "Password",
                errorText: "Please enter your password",
                width: width,
                label: "",
                height: height)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(() => AppCheckBox(
                          checkColor: AppColors.tallyColor,
                          isRememberMe: loginController.isRememberMe.value,
                          setIsRememberMe: loginController.setIsRememberMe)),
                      const Text(
                        "Remember me",
                        style: TextStyle(color: AppColors.darkBackgroundColor),
                      )
                    ],
                  ),
                  GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                      child: const Text(
                        'Forgot Your Password?',
                        style: TextStyle(
                            color: AppColors.tallyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: height * .1,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: AppButton(
                buttonHeight: 50,
                pressedFunction: () => loginController.submit(context),
                buttonColor: AppColors.tallyColor,
                buttonText: 'Sign In',
                buttonRadius: 10,
                textColor:
                (loginController.usernameController.text.isNotEmpty &&
                    loginController.passwordController.text.isNotEmpty)
                    ? AppColors.lightBackgroundColor
                    : AppColors.darkBackgroundColor,
              ),
            ),
            SizedBox(
              height: height * .025,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      width: width * .3,
                      child: const Divider(
                        indent: 20,
                        color: AppColors.darkBackgroundColor,
                        height: 1,
                        thickness: .1,
                      )),
                  SizedBox(
                    width: width * .02,
                  ),
                  Text(
                    'or sign in with',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(
                    width: width * .02,
                  ),
                  SizedBox(
                      width: width * .3,
                      child: const Divider(
                        endIndent: 20,
                        color: AppColors.darkBackgroundColor,
                        height: 1,
                        thickness: .1,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: height * .025,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: width * .3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 17,
                    backgroundColor: AppColors.lightGrey,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.lightBackgroundColor,
                      child: Image.asset(
                        AppImages.googlePng,
                        width: 17,
                        height: 17,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 17,
                    backgroundColor: AppColors.lightGrey,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.lightBackgroundColor,
                      child: Image.asset(
                        AppImages.applePng,
                        width: 17,
                        height: 17,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 17,
                    backgroundColor: AppColors.lightGrey,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: AppColors.lightBackgroundColor,
                      child: Image.asset(
                        AppImages.facebookPng,
                        width: 17,
                        height: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * .2,
            ),
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.signup),
              child: RichText(
                text: const TextSpan(
                    style: TextStyle(
                        fontSize: 12,
                        wordSpacing: 3,
                        color: AppColors.darkBackgroundColor),
                    children: [
                      TextSpan(text: "Don’t have an account? "),
                      TextSpan(
                          text: "Sign Up",
                          style: TextStyle(
                              color: AppColors.tallyColor,
                              fontWeight: FontWeight.w400)),
                    ]),
              ),
            ),
            // SizedBox(
            //   height: height * .015,
            // ),
          ],
        ),
      ),
    );
  }
}
