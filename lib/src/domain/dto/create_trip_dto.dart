class CreateTripDto {
  //Used to parse data to API
  late String driverId;
  late String status;
  late String startLocation;
  late String endLocation;
  late double duration;
  late double distance;
  late String paymentStatus;
  late String startDate;
  late double amount;
  late String endDate;
  late String rideType;
  late String tripType;

  CreateTripDto(
      {required this.driverId,
      required this.status,
      required this.startLocation,
      required this.endLocation,
      required this.duration,
      required this.distance,
      required this.paymentStatus,
      required this.startDate,
      required this.amount,
      required this.endDate,
      required this.rideType,
      required this.tripType});

  toJson() {
    return {
      "driverId": driverId,
      "status": status,
      "amount": amount,
      "startLocation": startLocation,
      "endLocation": endLocation,
      "duration": duration,
      "distance": distance,
      "paymentStatus": paymentStatus,
      "startDate": startDate,
      "endDate": endDate,
      "rideType": rideType,
      "tripType": tripType,
    };
  }
}
