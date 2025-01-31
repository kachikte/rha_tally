import 'package:rha/src/domain/domain.dart';

abstract class SignUpInterface {
  Future<ResponseModel> signUp({required SignUpDto signUpDto});
  Future<ResponseModel> verifyOtp({required VerifyOtpDto verifyOtpDto});
  Future<ResponseModel> personalInfo(
      {required PersonalInfoDto personalInfoDto});
  Future<ResponseModel> initForgotPassword({required String email});
  Future<ResponseModel> forgotPassword(
      {required String otp, required String password});
}
