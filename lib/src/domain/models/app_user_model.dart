import 'package:get/get.dart';

class AppUserModel extends GetxController {
  late RxString firstName;
  late RxString imageUrl;
  late RxString lastName;
  late RxString roleId;
  late RxString email;
  late RxString phone;
  late RxString gender;
  late RxString brand;
  late RxString model;
  late RxString year;
  late RxString color;
  late RxString plateNumber;
  late RxString documentCategory;

  AppUserModel.empty();

  AppUserModel(
      {required this.firstName,
      required this.imageUrl,
      required this.lastName,
      required this.roleId,
      required this.email,
      required this.phone,
      required this.gender,
      required this.brand,
      required this.model,
      required this.year,
      required this.color,
      required this.plateNumber,
      required this.documentCategory});
}
