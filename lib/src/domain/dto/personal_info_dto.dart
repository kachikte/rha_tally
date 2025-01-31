class PersonalInfoDto {
  String? email;
  String? firstname;
  String? lastname;
  String? gender;
  String? brand;
  String? model;
  String? year;
  String? color;
  String? plateNumber;

  PersonalInfoDto(
      {required this.email,
      required this.firstname,
      required this.lastname,
      required this.gender,
      required this.brand,
      required this.model,
      required this.year,
      required this.color,
      required this.plateNumber});

  toJson() {
    return {
      "email": email,
      "firstname": firstname,
      "lastname": lastname,
      "gender": gender,
      "brand": brand,
      "model": model,
      "year": year,
      "color": color,
      "plateNumber": plateNumber
    };
  }
}
