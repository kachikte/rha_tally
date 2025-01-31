import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rha/src/config/config.dart';
import 'package:rha/src/domain/domain.dart';
import 'package:rha/src/presentation/presentation.dart';
import 'package:rha/src/utils/util_functions.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen();

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {

  SignupController signupController = Get.find();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> forgotPassword() async {
    if (newPasswordController.text == '' ||
        confirmPasswordController.text == '') {
      UtilFunctions.showTopSnackError(context, 'Missing fields');
      return;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      UtilFunctions.showTopSnackError(context, 'Passsword not the same');
      return;
    }

    UtilFunctions.showOverLay(context);
    ResponseModel responseModel = await signupController.forgotPassword(
        signupController.otp.value, confirmPasswordController.text);
    if (context.mounted) {
      UtilFunctions.hideOverLay(context);
      if (responseModel.isError) {
        UtilFunctions.showTopSnackError(context, responseModel.data);
      } else {
        // log('Has been registered - ${responseModel.data['insertedId']}');
        // signupController.userId.value = responseModel.data['insertedId'];
        Get.toNamed(AppRoutes.status, arguments: {
          'text': 'Password Updated Successfully',
          'function': AppRoutes.login,
          'icon': const CircleAvatar(
            radius: 62,
            backgroundColor: AppColors.appGreen,
            child: CircleAvatar(
              radius: 61,
              backgroundColor: AppColors.lightBackgroundColor,
              child: CircleAvatar(
                radius: 56,
                backgroundColor: AppColors.appGreen,
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: AppColors.lightBackgroundColor,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: AppColors.appGreen,
                    child: Icon(
                      Icons.check,
                      size: 50,
                      color: AppColors.lightBackgroundColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
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
                    'New Password',
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
                    'Enter a new password for your account',
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
                    textEditingController: newPasswordController,
                    hintText: "New Password",
                    errorText: "Please enter your Password",
                    width: width,
                    label: "",
                    height: height),
                AppInput(
                    textEditingController: confirmPasswordController,
                    hintText: "Confirm Password",
                    errorText: "Please enter your Password",
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
                    buttonText: 'Update'),
                SizedBox(
                  height: height * .3,
                ),
              ],
            ),
          ),
        ));
  }
}
