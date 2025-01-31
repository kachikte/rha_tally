import 'package:rha/src/domain/domain.dart';

abstract class AuthInterface {
  Future<ResponseModel> getProfile(
      {required String authorization, required String accessToken});
  // Future<ResponseModel> updateProfile({required String authorization, required String accessToken, required UserProfileDto userProfileDto});
}
