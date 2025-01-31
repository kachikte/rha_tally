class TripModel {
  late String id;
  late String userId;
  late String driverId;
  late String status;
  late double amount;
  late String startLocation;
  late String endLocation;
  late double duration;
  late double distance;
  late String paymentStatus;
  late String startDate;
  late String endDate;
  late String? rideType;
  late String? tripType;

  TripModel.empty();

  TripModel({
    required this.id,
    required this.userId,
    required this.driverId,
    required this.status,
    required this.amount,
    required this.startLocation,
    required this.endLocation,
    required this.duration,
    required this.distance,
    required this.paymentStatus,
    required this.startDate,
    required this.endDate,
    required this.rideType,
    required this.tripType,
  });

  TripModel.fromJson({required json}) {
    id = json["_id"];
    userId = json["userId"];
    driverId = json["driverId"];
    status = json["status"];
    amount = json["amount"];
    startLocation = json["startLocation"];
    endLocation = json["endLocation"];
    duration = json["duration"];
    distance = json["distance"];
    paymentStatus = json["paymentStatus"];
    startDate = json["startDate"];
    endDate = json["endDate"];
    rideType = json["rideType"];
    tripType = json["tripType"];
  }
}
