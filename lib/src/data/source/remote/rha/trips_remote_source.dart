import 'dart:developer';

import 'package:rha/src/data/data.dart';
import 'package:rha/src/domain/domain.dart';

class TripsRemoteSource {
  BaseDio baseDio = BaseDio();

  createTrip({required String token, required CreateTripDto createTripDto}) async {
    baseDio.dio.options.headers["Authorization"] =
    "Bearer $token";
    return await baseDio.dio
        .post(ApiUrls.createTrip, data: createTripDto.toJson());
  }

  getTrips({required String token}) async {
    log('trip ttoekm - $token');
    baseDio.dio.options.headers["Authorization"] =
    "Bearer $token";
    return await baseDio.dio
        .get(ApiUrls.getTrips);
  }
}
