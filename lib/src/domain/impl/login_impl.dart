import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:rha/src/data/data.dart';
import 'package:rha/src/domain/domain.dart';

class LoginImpl extends LoginInterface {
  LoginRemoteSource loginRemoteSource = LoginRemoteSource();

  @override
  Future<ResponseModel> login({required LoginDto loginDto}) async {
    ResponseModel responseModel = ResponseModel.empty();
    try {
      dio.Response response = await loginRemoteSource.login(loginDto: loginDto);
      log('This is the login response data  - ${response.data}');

      var loginData = json.decode(response.toString())['data'];

      log('This is the login response data 11  - $loginData');

      if (loginData['roleId'] != "3") {
        responseModel.isError = true;
        responseModel.data = 'User is not a driver';
        return responseModel;
      } else {
        responseModel.isError = false;
        responseModel.data = loginData;
        return responseModel;
      }
    } on dio.DioError catch (e) {
      // log('This is the login error data 11  - ${e.error} - ${e.response} - ${json.decode(e.response.toString())['data']}');

      responseModel.isError = true;
      responseModel.data = json.decode(e.response.toString()) == null ? 'Error' : json.decode(e.response.toString())['data'];
      return responseModel;
    }
  }
}
