class SignUpDto {
  String? email;
  String? phone;
  String? firstName;
  String? lastName;
  String? password;

  SignUpDto(
      {required this.email,
      required this.phone,
        required this.lastName,
      required this.firstName,
      required this.password});

  toJson() {
    return {
      "email": email,
      "phone": phone,
      "firstname": firstName,
      "lastname": lastName,
      "password": password
    };
  }
}
