import 'package:rha/src/domain/domain.dart';

abstract class UserProfileInterface {
  Future<ResponseModel> getProfile(
      {required String authorization, required String accessToken});
  Future<ResponseModel> updateProfile(
      {required String authorization,
      required String accessToken,
      required UserProfileDto userProfileDto});

  Future<ResponseModel> logout(
      {required String authorization, required String accessToken});

  Future<ResponseModel> delete(
      {required String authorization, required String accessToken});

  Future<ResponseModel> changePassword(
      {required String authorization,
      required String accessToken,
      required String oldPassword,
      required String newPassword});

  Future<ResponseModel> updateOnline(
      {required String accessToken,
        required bool isOnline});

  Future<ResponseModel> updateLocation(
      {required String accessToken,
        required double lat,
        required double lng});
}
