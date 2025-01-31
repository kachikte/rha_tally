import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:rha/src/data/data.dart';
import 'package:rha/src/domain/domain.dart';
import 'package:rha/src/domain/models/user_profile_model.dart';

class UserProfileImpl implements UserProfileInterface {
  ProfileRemoteSource profileRemoteSource = ProfileRemoteSource();

  @override
  Future<ResponseModel> getProfile(
      {required String authorization, required String accessToken}) async {
    ResponseModel responseModel = ResponseModel.empty();

    try {
      dio.Response response = await profileRemoteSource.getProfile(
          authorization: authorization, accessToken: accessToken);
      var userData = json.decode(response.toString())["data"];
      UserProfileModel userProfileModel =
          UserProfileModel.fromJson(json: userData);
      responseModel.isError = false;
      responseModel.data = userProfileModel;
    } on dio.DioError catch (e) {
      responseModel.isError = true;
      responseModel.data = json.decode(e.response.toString())['data'];
    }

    return responseModel;
  }

  @override
  Future<ResponseModel> updateProfile(
      {required String authorization,
      required String accessToken,
      required UserProfileDto userProfileDto}) async {
    // TODO: implement updateProfile
    ResponseModel responseModel = ResponseModel.empty();

    try {
      dio.Response response = await profileRemoteSource.updateProfile(
          authorization: authorization,
          accessToken: accessToken,
          userProfileDto: userProfileDto);
      var userData = json.decode(response.toString())["data"];
      // UserProfileModel userProfileModel = UserProfileModel.fromJson(json: userData);
      responseModel.isError = false;
      // responseModel.data = userProfileModel;
      responseModel.data = "";
    } on dio.DioError catch (e) {
      print(
          "this is the update profile error === ${e.response?.statusCode} ${e.response?.data} ${e.toString()}");
      responseModel.isError = true;
      responseModel.data = json.decode(e.response.toString())['data'];
    }

    return responseModel;
  }

  @override
  Future<ResponseModel> logout(
      {required String authorization, required String accessToken}) async {
    ResponseModel responseModel = ResponseModel.empty();

    try {
      dio.Response response = await profileRemoteSource.logout(
          authorization: authorization, accessToken: accessToken);
      responseModel.isError = false;
      responseModel.data = response.data;
    } on dio.DioError catch (e) {
      responseModel.isError = true;
      responseModel.data = json.decode(e.response.toString())['data'];
    }

    return responseModel;
  }

  @override
  Future<ResponseModel> delete(
      {required String authorization, required String accessToken}) async {
    ResponseModel responseModel = ResponseModel.empty();

    try {
      dio.Response response = await profileRemoteSource.delete(
          authorization: authorization, accessToken: accessToken);
      responseModel.isError = false;
      log('This is the deleted response data  - ${response.data}');
      responseModel.data = response.data;
    } on dio.DioError catch (e) {
      responseModel.isError = true;
      responseModel.data = json.decode(e.response.toString())['data'];
    }

    return responseModel;
  }

  @override
  Future<ResponseModel> changePassword(
      {required String authorization,
      required String accessToken,
      required String oldPassword,
      required String newPassword}) async {
    ResponseModel responseModel = ResponseModel.empty();

    try {
      dio.Response response = await profileRemoteSource.changePassword(
          authorization: authorization,
          accessToken: accessToken,
          oldPassword: oldPassword,
          newPassword: newPassword);
      responseModel.isError = false;
      responseModel.data = response.data;
    } on dio.DioError catch (e) {
      responseModel.isError = true;
      responseModel.data = json.decode(e.response.toString())['data'];
    }

    return responseModel;
  }

  @override
  Future<ResponseModel> updateOnline(
      {
        required String accessToken,
        required bool isOnline}) async {
    // TODO: implement updateProfile
    ResponseModel responseModel = ResponseModel.empty();

    try {
      dio.Response response = await profileRemoteSource.updateOnline(
          accessToken: accessToken,
          isOnline: isOnline);
      var userData = json.decode(response.toString())["data"];
      // UserProfileModel userProfileModel = UserProfileModel.fromJson(json: userData);
      responseModel.isError = false;
      // responseModel.data = userProfileModel;
      responseModel.data = "";
    } on dio.DioError catch (e) {
      print(
          "this is the update profile error === ${e.response?.statusCode} ${e.response?.data} ${e.toString()}");
      responseModel.isError = true;
      responseModel.data = json.decode(e.response.toString())['data'];
    }

    return responseModel;
  }


  @override
  Future<ResponseModel> updateLocation(
      {required String accessToken,
        required double lat,
        required double lng}) async {
    // TODO: implement updateProfile
    ResponseModel responseModel = ResponseModel.empty();

    try {
      dio.Response response = await profileRemoteSource.updateLocation(
          lat: lat,
          accessToken: accessToken,
          lng: lng);
      var userData = json.decode(response.toString())["data"];
      // UserProfileModel userProfileModel = UserProfileModel.fromJson(json: userData);
      responseModel.isError = false;
      // responseModel.data = userProfileModel;
      responseModel.data = "";
    } on dio.DioError catch (e) {
      print(
          "this is the update profile error === ${e.response?.statusCode} ${e.response?.data} ${e.toString()}");
      responseModel.isError = true;
      responseModel.data = json.decode(e.response.toString())['data'];
    }

    return responseModel;
  }
}
