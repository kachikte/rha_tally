import 'package:rha/src/data/data.dart';
import 'package:rha/src/domain/domain.dart';

class SignUpRemoteSource {
  BaseDio baseDio = BaseDio();

  signUp({required SignUpDto signUpDto}) async {
    return await baseDio.dio
        .post(ApiUrls.createAccount, data: signUpDto.toJson());
  }

  verifyOtp({required VerifyOtpDto verifyOtpDto}) async {
    return await baseDio.dio
        .post(ApiUrls.verifyOtp, data: verifyOtpDto.toJson());
  }

  personalInfo({required PersonalInfoDto personalInfoDto}) async {
    return await baseDio.dio
        .post(ApiUrls.personalInfo, data: personalInfoDto.toJson());
  }

  initForgotPassword({required String email}) async {
    return await baseDio.dio
        .post(ApiUrls.initForgotPassword, data: {"email": email});
  }

  forgotPassword({required String otp, required String password}) async {
    return await baseDio.dio
        .post(ApiUrls.forgotPassword, data: {"otp": otp, "password": password});
  }
}
