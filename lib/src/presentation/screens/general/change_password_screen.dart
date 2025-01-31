import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rha/src/config/config.dart';
import 'package:rha/src/presentation/presentation.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen();

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    TextEditingController oldPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

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
                Container(
                  width: width,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Change Password',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: height * .02,
                ),
                AppInput(
                    textEditingController: oldPasswordController,
                    hintText: "Old Password",
                    errorText: "Please enter your Password",
                    width: width,
                    label: "",
                    height: height),
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
                    pressedFunction: () => Get.back(),
                    buttonColor: AppColors.tallyColor,
                    buttonText: 'Update Password'),
                SizedBox(
                  height: height * .3,
                ),
              ],
            ),
          ),
        ));
  }
}
