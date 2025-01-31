import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rha/src/config/config.dart';
import 'package:rha/src/domain/domain.dart';
import 'package:rha/src/presentation/presentation.dart';
import 'package:rha/src/utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignupController signupController = Get.find();

  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> signUp() async {
    if (emailController.text == '' ||
        phoneController.text == '' ||
        passwordController.text == '' ||
        lastNameController.text == '' ||
        firstNameController.text == '') {
      UtilFunctions.showTopSnackError(context, 'Missing fields');
      return;
    }
    UtilFunctions.showOverLay(context);
    SignUpDto signUpDto = SignUpDto(
        email: emailController.text,
        phone: phoneController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        password: passwordController.text);
    ResponseModel responseModel = await signupController.signUp(signUpDto);
    if (context.mounted) {
      UtilFunctions.hideOverLay(context);
      if (responseModel.isError) {
        UtilFunctions.showTopSnackError(context, responseModel.data);
      } else {
        log('Has been registered - ${responseModel.data['insertedId']}');
        signupController.userId.value = responseModel.data['insertedId'];
        Get.toNamed(AppRoutes.accountVerification, arguments: {
          'email': emailController.text,
          'phone': phoneController.text,
          'type': Constants.verifyScreen
        });
      }
    }
  }

  Future<void> forgotPassword() async {
    Get.toNamed(AppRoutes.signup);
  }

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
                "Create Account",
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            SizedBox(
              height: height * .025,
            ),
            Row(
              children: [
                SizedBox(
                  width: width * .5,
                  child: AppInput(
                      textEditingController: firstNameController,
                      hintText: "First Name",
                      errorText: "Please enter your first name",
                      width: width,
                      label: "",
                      height: height),
                ),
                SizedBox(
                  width: width * .5,
                  child: AppInput(
                      textEditingController: lastNameController,
                      hintText: "Last Name",
                      errorText: "Please enter your last name",
                      width: width,
                      label: "",
                      height: height),
                ),
              ],
            ),
            AppInput(
                textEditingController: emailController,
                hintText: "Email Address",
                errorText: "Please enter your username",
                width: width,
                label: "",
                height: height),
            AppInput(
                textInputType: TextInputType.number,
                textEditingController: phoneController,
                hintText: "Your mobile number",
                errorText: "Please enter your phone number",
                width: width,
                label: "",
                height: height),
            Obx(() => AppInput(
                textEditingController: passwordController,
                suffixIcon: GestureDetector(
                  onTap: () {
                    log('trying to change the obscure = ${signupController.isObscure.value}');
                    signupController.isObscure.value =
                    !signupController.isObscure.value;
                  },
                  child: signupController.isObscure.value
                      ? const Icon(Icons.remove_red_eye)
                      : const Icon(Icons.remove_red_eye_outlined),
                ),
                type: Constants.passwordFieldType,
                pinObscure: signupController.isObscure.value,
                // icon: Image.asset(AppImages.tallyLogo),
                hintText: "Password",
                errorText: "Please enter your password",
                width: width,
                label: "",
                height: height)),
            SizedBox(
              height: height * .04,
            ),
            Container(
                width: width,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'By signing up, you agree to our Terms and Conditions and Privacy Policy.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: AppColors.darkBackgroundColor),
                )),
            SizedBox(
              height: height * .02,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: AppButton(
                buttonHeight: 50,
                pressedFunction: () => signUp(),
                buttonColor: AppColors.tallyColor,
                buttonText: 'Sign Up',
                buttonRadius: 10,
                textColor: (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty)
                    ? AppColors.lightBackgroundColor
                    : AppColors.darkBackgroundColor,
              ),
            ),
            SizedBox(
              height: height * .03,
            ),
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.login),
              child: RichText(
                text: const TextSpan(
                    style: TextStyle(
                        fontSize: 12,
                        wordSpacing: 3,
                        color: AppColors.darkBackgroundColor),
                    children: [
                      TextSpan(text: "Already have an account? "),
                      TextSpan(
                          text: "Log In",
                          style: TextStyle(
                              color: AppColors.tallyColor,
                              fontWeight: FontWeight.w400)),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
