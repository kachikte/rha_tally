import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rha/src/config/config.dart';
import 'package:rha/src/presentation/presentation.dart';
import 'package:rha/src/utils/util_functions.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController = TextEditingController(
        text: profileController.appUserModel.firstName.value);

    TextEditingController lastNameController = TextEditingController(
        text: profileController.appUserModel.lastName.value);

    TextEditingController emailController =
    TextEditingController(text: profileController.appUserModel.email.value);

    TextEditingController phoneController =
    TextEditingController(text: profileController.appUserModel.phone.value);

    TextEditingController dobController = TextEditingController();
    final Size size = MediaQuery.of(context).size;

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.lightBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.lightBackgroundColor,
        leading: const BackButton(
          color: AppColors.darkBackgroundColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: width,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Profile",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  SizedBox(
                    height: 40,
                    child: AppButton(
                      buttonRadius: 10,
                      pressedFunction: () {},
                      buttonColor: AppColors.tallyColor,
                      buttonText: 'Edit',
                      buttonIcon: const Icon(
                        Icons.edit,
                        color: AppColors.darkBackgroundColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: height * .02,
            ),
            Stack(
              children: [
                CircleAvatar(
                    radius: 35,
                    backgroundColor: AppColors.darkBackgroundColor,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(28)),
                      child: Image.network(
                        profileController.appUserModel.imageUrl
                            .value, // Replace with your actual image URL
                        width: 45,
                        height: 45,
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 45,
                          ); // Show an error icon if the image fails to load
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return CircularProgressIndicator(); // Show a loading spinner while the image is loading
                        },
                      ),
                    )),
                Positioned(
                  left: 40,
                  top: 40,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.yellow[700],
                    child: const Icon(
                      Icons.camera_alt,
                      size: 15,
                      color: AppColors.darkBackgroundColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * .02,
            ),
            Row(
              children: [
                SizedBox(
                  width: width * .5,
                  child: AppInput(
                      textEditingController: firstNameController,
                      // suffixIcon: inputError
                      //     ? Icon(
                      //         Icons.info_outline,
                      //         color: AppColors.appRed,
                      //       )
                      //     : const SizedBox(),
                      // isError: inputError,
                      // icon: const Icon(Icons.person_outline),
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
                      // suffixIcon: inputError
                      //     ? Icon(
                      //         Icons.info_outline,
                      //         color: AppColors.appRed,
                      //       )
                      //     : const SizedBox(),
                      // isError: inputError,
                      // icon: const Icon(Icons.person_outline),
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
                // suffixIcon: inputError
                //     ? Icon(
                //         Icons.info_outline,
                //         color: AppColors.appRed,
                //       )
                //     : const SizedBox(),
                // isError: inputError,
                // icon: Image.asset(AppImages.tallyLogo),
                hintText: "Email Address",
                errorText: "Please enter your username",
                width: width,
                label: "",
                height: height),
            AppInput(
                textInputType: TextInputType.number,
                textEditingController: phoneController,
                // suffixIcon: inputError
                //     ? Icon(
                //         Icons.info_outline,
                //         color: AppColors.appRed,
                //       )
                //     : const SizedBox(),
                // isError: inputError,
                // icon: const Icon(Icons.phone),
                hintText: "Your mobile number",
                errorText: "Please enter your phone number",
                width: width,
                label: "",
                height: height),
            AppInput(
                textEditingController: dobController,
                // suffixIcon: inputError
                //     ? Icon(
                //         Icons.info_outline,
                //         color: AppColors.appRed,
                //       )
                //     : GestureDetector(
                //         onTap: () {
                //           log('trying to change the obscure = $pinObscure');
                //           ref.read(pinInputCompleteProvider.notifier).state =
                //               !pinObscure;
                //         },
                //         child: pinObscure
                //             ? const Icon(Icons.remove_red_eye)
                //             : const Icon(Icons.remove_red_eye_outlined),
                //       ),
                // isError: inputError,
                // icon: Image.asset(AppImages.tallyLogo),
                hintText: "Date of Birth",
                errorText: "",
                width: width,
                label: "",
                suffixIcon: const Icon(
                  Icons.calendar_today_rounded,
                  color: AppColors.tallyColor,
                ),
                height: height),
            const Divider(
              indent: 10,
              endIndent: 10,
              thickness: 1,
              height: 2,
            ),
            SizedBox(
              height: height * .015,
            ),
            buttonNext(
                size: size,
                route: AppRoutes.changePassword,
                name: 'Change Password'),
            SizedBox(
              height: height * .015,
            ),
            const Divider(
              indent: 10,
              endIndent: 10,
              thickness: 1,
              height: 2,
            ),
            SizedBox(
              height: height * .015,
            ),
            GestureDetector(
              onTap: () async {
                UtilFunctions.showOverLay(context);
                bool res = await profileController.logout(
                    isRememberMe: profileController.getRememberMeValue());
                UtilFunctions.hideOverLay(context);
                if (res) {
                  Get.offAndToNamed(AppRoutes.login);
                } else {
                  return;
                }
              },
              child: Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  CircleAvatar(
                    backgroundColor: AppColors.lightGrey.withOpacity(.2),
                    child: const Icon(
                      size: 20,
                      Icons.logout,
                      color: AppColors.darkBackgroundColor,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Log Out',
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.deleteAccount),
              child: Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  CircleAvatar(
                    backgroundColor: AppColors.appRed.withOpacity(.2),
                    child: Icon(
                      size: 20,
                      Icons.delete_outline,
                      color: AppColors.appRed,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Delete Account',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AppColors.appRed),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonNext(
      {required Size size, required String route, required String name}) {
    return GestureDetector(
      onTap: () => Get.toNamed(route),
      child: Container(
        width: size.width,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 15),
        decoration: BoxDecoration(
            color: AppColors.lightGrey.withOpacity(.3),
            border: Border.all(
                color: AppColors.lightGrey.withOpacity(.3),
                width: 1,
                style: BorderStyle.solid),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}
