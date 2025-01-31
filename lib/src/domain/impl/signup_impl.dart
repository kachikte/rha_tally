import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:rha/src/data/repository/signup_interface.dart';
import 'package:rha/src/data/source/remote/rha/signup_remote_source.dart';
import 'package:rha/src/domain/domain.dart';

class SignUpImpl extends SignUpInterface {
  SignUpRemoteSource signUpRemoteSource = SignUpRemoteSource();

  @override
  Future<ResponseModel> signUp({required SignUpDto signUpDto}) async {
    ResponseModel responseModel = ResponseModel.empty();
    try {
      dio.Response response =
          await signUpRemoteSource.signUp(signUpDto: signUpDto);
      var signupData = json.decode(response.toString())['data'];
      responseModel.isError = false;
      responseModel.data = signupData;
      return responseModel;
    } on dio.DioError catch (e) {
      responseModel.isError = true;
      responseModel.data = json.decode(e.response.toString()) == null ? 'Error' : json.decode(e.response.toString())['data'];
      return responseModel;
    }
  }

  @override
  Future<ResponseModel> verifyOtp({required VerifyOtpDto verifyOtpDto}) async {
    ResponseModel responseModel = ResponseModel.empty();

    try {
      var data = await signUpRemoteSource.verifyOtp(verifyOtpDto: verifyOtpDto);

      log('This is the otp data - $data ');

      // var jsonData = json.decode(data.toString())['data'];
      var jsonData = json.decode(data.toString())['data'];

      log('This is the otp data 11- $jsonData ');

      responseModel.isError = false;
      // responseModel.data = jsonData;

      return responseModel;
    } on dio.DioError catch (e) {
      responseModel.isError = true;
      responseModel.data = json.decode(e.response.toString()) == null ? 'Error' : json.decode(e.response.toString())['data'];
      return responseModel;
    }
  }

  @override
  Future<ResponseModel> personalInfo(
      {required PersonalInfoDto personalInfoDto}) async {
    ResponseModel responseModel = ResponseModel.empty();

    try {
      var data = await signUpRemoteSource.personalInfo(
          personalInfoDto: personalInfoDto);

      var jsonData = json.decode(data.toString())['data'];

      responseModel.isError = false;
      responseModel.data = jsonData;

      return responseModel;
    } on dio.DioError catch (e) {
      log('this is the error - ${e.toString()}');
      responseModel.isError = true;
      responseModel.data = json.decode(e.response.toString())['data'];
      return responseModel;
    }
  }

  @override
  Future<ResponseModel> initForgotPassword({required String email}) async {
    ResponseModel responseModel = ResponseModel.empty();

    try {
      var data = await signUpRemoteSource.initForgotPassword(email: email);

      var jsonData = json.decode(data.toString())['data'];

      responseModel.isError = false;
      responseModel.data = jsonData;

      return responseModel;
    } on dio.DioError catch (e) {
      log('this is the error - ${e.toString()}');
      responseModel.isError = true;
      responseModel.data = json.decode(e.response.toString())['data'];
      return responseModel;
    }
  }

  @override
  Future<ResponseModel> forgotPassword(
      {required String otp, required String password}) async {
    ResponseModel responseModel = ResponseModel.empty();

    try {
      var data =
          await signUpRemoteSource.forgotPassword(otp: otp, password: password);

      var jsonData = json.decode(data.toString())['data'];

      responseModel.isError = false;
      responseModel.data = jsonData;

      return responseModel;
    } on dio.DioError catch (e) {
      log('this is the error - ${e.toString()}');
      responseModel.isError = true;
      responseModel.data = json.decode(e.response.toString())['data'];
      return responseModel;
    }
  }
}
