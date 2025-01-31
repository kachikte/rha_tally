import 'package:rha/src/domain/domain.dart';

abstract class TripsInterface {
  Future<ResponseModel> createTrip({required String token, required CreateTripDto createTripDto});
  Future getTrips({required String token});
}
