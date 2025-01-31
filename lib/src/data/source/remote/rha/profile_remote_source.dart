import 'package:rha/src/data/data.dart';
import 'package:rha/src/domain/domain.dart';
import 'package:rha/src/utils/utils.dart';

class ProfileRemoteSource {
  BaseDio baseDio = BaseDio();

  getProfile(
      {required String authorization, required String accessToken}) async {
    baseDio.dio.options.headers["Authorization"] =
        "$authorization $accessToken";
    return await baseDio.dio.get(ApiUrls.getUserDetail);
  }

  Future updateProfile(
      {required String authorization,
      required String accessToken,
      required UserProfileDto userProfileDto}) async {
    print(
        "update data == ${userProfileDto.phoneNumber} == ${userProfileDto.countryCode} == ${userProfileDto.firstName} == ${userProfileDto.lastName} == ${userProfileDto.streetNumber} == ${userProfileDto.streetName} == ${userProfileDto.city} == ${userProfileDto.map} == ${userProfileDto.state} == ${userProfileDto.country}");
    final data = {
      "phone_number": userProfileDto.phoneNumber,
      "country_code": userProfileDto.countryCode,
      "first_name": userProfileDto.firstName,
      "last_name": userProfileDto.lastName,
      "street_number": userProfileDto.streetNumber,
      "street_name": userProfileDto.streetName,
      "city": userProfileDto.city,
      "map": userProfileDto.map,
      "state": userProfileDto.state,
      "country": userProfileDto.country,
    };

    baseDio.dio.options.headers["Authorization"] =
        "$authorization $accessToken";
    return await baseDio.dio.put(ApiUrls.createAccount, data: data);
  }

  Future updateNotificationToken({required String notificationToken}) async {
    String? accessToken = await SecuredStorage.readData(key: StoredKeys.TOKEN);

    baseDio.dio.options.headers["Authorization"] = "Bearer $accessToken";

    print("this is the updated user token === now === ");

    return await baseDio.dio.put("${ApiUrls.createAccount}$notificationToken");
  }

  Future logout(
      {required String authorization, required String accessToken}) async {
    baseDio.dio.options.headers["Authorization"] =
        "$authorization $accessToken";
    return await baseDio.dio.post(ApiUrls.logout);
  }

  Future delete(
      {required String authorization, required String accessToken}) async {
    baseDio.dio.options.headers["Authorization"] =
        "$authorization $accessToken";
    return await baseDio.dio.post(ApiUrls.delete);
  }

  Future changePassword(
      {required String authorization,
      required String accessToken,
      required String oldPassword,
      required String newPassword}) async {
    baseDio.dio.options.headers["Authorization"] =
        "$authorization $accessToken";
    return await baseDio.dio.post(ApiUrls.changePassword,
        data: {"oldPassword": oldPassword, "newPassword": newPassword});
  }

  Future updateOnline(
      {required bool isOnline,       required String accessToken,
      }) async {
    final data = {
      "isOnline": isOnline,
    };

    baseDio.dio.options.headers["Authorization"] =
    "Bearer $accessToken";
    return await baseDio.dio.post(ApiUrls.editOnline, data: data);
  }

  Future updateLocation(
      {required double lat,  required double lng,     required String accessToken,
      }) async {
    final data = {
      "lat": lat,
      "lng": lng
    };

    baseDio.dio.options.headers["Authorization"] =
    "Bearer $accessToken";
    return await baseDio.dio.post(ApiUrls.editLocation, data: data);
  }
}
