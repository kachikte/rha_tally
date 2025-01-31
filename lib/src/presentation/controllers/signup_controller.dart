import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rha/src/domain/domain.dart';
import 'package:rha/src/domain/impl/signup_impl.dart';
import 'package:rha/src/presentation/controllers/controllers.dart';
import 'package:rha/src/presentation/controllers/notification_controller.dart';

class SignupController extends GetxController {
  RxString userId = "".obs;
  RxString otp = "".obs;

  TextEditingController emailSignupController = TextEditingController();
  SignUpImpl signUpImpl = SignUpImpl();
  ProfileController profileController = ProfileController();
  NotificationController notificationController = NotificationController();

  void setObscure() {
    isObscure.value = !isObscure.value;
  }

  void setIsRememberMe(value) {
    isRememberMe.value = !isRememberMe.value;
  }

  RxBool isRememberMe = false.obs;

  RxBool isObscure = true.obs;

  Future<ResponseModel> signUp(SignUpDto signUpDto) {
    return signUpImpl.signUp(signUpDto: signUpDto);
  }

  Future<ResponseModel> verifyOtp(VerifyOtpDto verifyOtpDto) {
    return signUpImpl.verifyOtp(verifyOtpDto: verifyOtpDto);
  }

  Future<ResponseModel> personalInfo(PersonalInfoDto personalInfoDto) {
    return signUpImpl.personalInfo(personalInfoDto: personalInfoDto);
  }

  Future<ResponseModel> initForgotPassword(String email) {
    return signUpImpl.initForgotPassword(email: email);
  }

  Future<ResponseModel> forgotPassword(String otp, String password) {
    return signUpImpl.forgotPassword(otp: otp, password: password);
  }
}
