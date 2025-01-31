import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rha/src/config/config.dart';
import 'package:rha/src/data/data.dart';
import 'package:rha/src/domain/domain.dart';
import 'package:rha/src/domain/models/user_profile_model.dart';
import 'package:rha/src/presentation/controllers/controllers.dart';
import 'package:rha/src/presentation/controllers/notification_controller.dart';
import 'package:rha/src/utils/utils.dart';

class LoginController extends GetxController {
  LoginImpl loginImpl = LoginImpl();

  RxString userId = ''.obs;

  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  AppDBNotifications appDBNotifications = AppDBNotifications();

  NotificationController notificationController = Get.find();

  ProfileController profileController = Get.find();

  void setObscure() {
    isObscure.value = !isObscure.value;
  }

  void setIsRememberMe(value) {
    isRememberMe.value = !isRememberMe.value;
  }

  RxBool isRememberMe = false.obs;

  RxBool isObscure = true.obs;

  final formKey = GlobalKey<FormState>();

  checkOnLogin() async {
    bool rememberMe = profileController.getRememberMeValue();

    if (rememberMe) {
      usernameController.text = profileController.emailGeneralStorage
          .readFromBox(key: StoredKeys.EMAIL);
      passwordController.text =
          (await SecuredStorage.readData(key: StoredKeys.PASSWORD))!;
    } else {
      usernameController.text = '';
      passwordController.text = '';
    }

    isRememberMe.value = rememberMe;

    await profileController.getAppInfo();
  }

  Future<ResponseModel> login(LoginDto loginDto) {
    return loginImpl.login(loginDto: loginDto);
  }

  void submit(BuildContext context) async {
    UtilFunctions.showOverLay(context);

    bool rememberMe = profileController.getRememberMeValue();

    if (rememberMe) {
      print("To delete db === $rememberMe");
      String username = profileController.getUsernameValue();
      print("To delete db one === $username");
      print("To delete db two === ${usernameController.text}");
      print("To delete db three === ${usernameController.text != username}");
      if (usernameController.text != username) {
        await appDBNotifications.dropNotificationTable();
      }
    }

    LoginDto loginDto = LoginDto(
        username: usernameController.text.trim(),
        password: passwordController.text.trim());

    print("this is coming hereeee == |");
    ResponseModel responseModel = await loginImpl.login(loginDto: loginDto);

    bool canContinue = true;
    if (responseModel.isError) {
      if (context.mounted) {
        UtilFunctions.hideOverLay(context);
      }
      UtilFunctions.getSnack(
          title: "Login Error",
          message: responseModel.data,
          colorText: AppColors.lightBackgroundColor,
          backgroundColor: AppColors.tallyColor);

      // UtilFunctions.getSnack(title: "Login Error", message: "Could not connect, Please try again", colorText: AppColors.lightBackgroundColor, backgroundColor: AppColors.primaryColor);

      canContinue = false;
    } else {
      log('This is the response data - ${responseModel.data}');
      log('This is the response data field - ${responseModel.data['email']}');

      LoginModel loginModel = LoginModel.fromJson(json: responseModel.data);

      userId.value = responseModel.data['userId'];

      await SecuredStorage.writeData(
          storageModel: StorageModel(
              key: StoredKeys.TOKEN, value: loginModel.accessToken));
      await SecuredStorage.writeData(
          storageModel: StorageModel(
              key: StoredKeys.AUTH, value: loginModel.authorization));

      if (isRememberMe.value) {
        profileController.rememberMeGeneralStorage.writeToBox(
            storageModel: StorageModel(
                key: StoredKeys.REMEMBERME,
                value: isRememberMe.value.toString()));
        await SecuredStorage.writeData(
            storageModel: StorageModel(
                key: StoredKeys.PASSWORD, value: loginDto.password));
      } else {
        profileController.rememberMeGeneralStorage
            .removeBox(key: StoredKeys.REMEMBERME);
        await SecuredStorage.delete(key: StoredKeys.PASSWORD);
      }

      if (context.mounted) {
        loginFinal(
            context: context,
            authorization: loginModel.authorization,
            token: loginModel.accessToken,
            password: loginDto.password);
      }
    }
  }

  loginFinal(
      {required BuildContext context,
      required String authorization,
      required String token,
      required String password}) async {

    ResponseModel responseModelProfile = await profileController.getProfile(
        authorization: authorization, accessToken: token);

    if (!responseModelProfile.isError) {
      log("Rntering herre profile details === ${responseModelProfile.data}");
      UserProfileModel userProfileModel =
          responseModelProfile.data as UserProfileModel;

      profileController.setProfileValues(
          userProfileModel: userProfileModel, uniqueKey: "");

      profileController.getProfileValues();
      const serverUrl = ApiUrls.url;
      var deviceId = Constants.deviceId;
      if (context.mounted) {
        UtilFunctions.hideOverLay(context);
      }
      Get.offAndToNamed(AppRoutes.locationChecker);
      // Get.offAndToNamed(AppRoutes.tripHome);
    }

    log("Rntering herre profile detailserror === ${responseModelProfile.data}");
    if (context.mounted) {
      UtilFunctions.hideOverLay(context);
      UtilFunctions.showTopSnackError(context, responseModelProfile.data);
    }
  }
}
