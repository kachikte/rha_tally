import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rha/src/config/config.dart';
import 'package:rha/src/domain/domain.dart';
import 'package:rha/src/presentation/presentation.dart';
import 'package:rha/src/utils/constants.dart';
import 'package:rha/src/utils/util_functions.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen();

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  SignupController signupController = Get.find();
  TextEditingController emailController = TextEditingController();

  Future<void> forgotPassword() async {
    if (emailController.text == '') {
      UtilFunctions.showTopSnackError(context, 'Missing fields');
      return;
    }
    UtilFunctions.showOverLay(context);
    ResponseModel responseModel =
    await signupController.initForgotPassword(emailController.text);
    if (context.mounted) {
      UtilFunctions.hideOverLay(context);
      if (responseModel.isError) {
        UtilFunctions.showTopSnackError(context, responseModel.data);
      } else {
        // log('Has been registered - ${responseModel.data['insertedId']}');
        // signupController.userId.value = responseModel.data['insertedId'];
        Get.toNamed(AppRoutes.accountVerification, arguments: {
          'email': emailController.text,
          'type': Constants.forgotScreen
        });
      }
    }
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
                    'Forgot Password',
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
                    'Enter your registered email or phone number',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.darkBackgroundColor.withOpacity(.4)),
                  ),
                ),
                SizedBox(
                  height: height * .04,
                ),
                AppInput(
                    textEditingController: emailController,
                    hintText: "Email/Phone Number",
                    errorText: "Please enter your Email/Phone Number",
                    width: width,
                    label: "",
                    height: height),
                SizedBox(
                  height: height * .1,
                ),
                AppButton(
                    buttonRadius: 10,
                    pressedFunction: () => forgotPassword(),
                    buttonColor: AppColors.tallyColor,
                    buttonText: 'Reset Password'),
                SizedBox(
                  height: height * .3,
                ),
                RichText(
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
              ],
            ),
          ),
        ));
  }
}
