class UserProfileModel {
  late String firstName;
  late String lastName;
  // late String username;
  late String email;
  late String phone;
  late String gender;
  late String roleId;
  late String brand;
  late String model;
  late String year;
  late String color;
  late String plateNumber;
  late String? documentUrl;
  late String? documentCategory;

  UserProfileModel.empty();

  setUniqueKey({required String uniqueKey}) {
    // uniqueToken = uniqueKey;
  }

  UserProfileModel({
    required this.firstName,
    required this.lastName,
    // required this.username,
    required this.email,
    required this.phone,
    required this.gender,
    required this.roleId,
    required this.brand,
    required this.model,
    required this.year,
    required this.color,
    required this.plateNumber,
    required this.documentUrl,
    // required this.uniqueToken,
    required this.documentCategory,
    // required this.subscriptionStatus
  });

  UserProfileModel.fromJson({required json}) {
    firstName = json["firstname"];
    lastName = json["lastname"];
    // username = json["username"];
    email = json["email"];
    phone = json["phone"];
    gender = json["gender"];
    roleId = json["roleId"];
    brand = json["carBrand"];
    model = json["carModel"];
    year = json["carYear"];
    color = json["carColor"];
    plateNumber = json["carPlateNumber"];
    documentCategory = json["documentCategory"] ?? '';
    documentUrl = json["documentUrl"] ?? '';
    // subscriptionStatus = json["subscription_status"] ?? "";
  }
}
