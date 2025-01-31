class LoginDto {
  //Used to parse data to API

  late String username;
  late String password;

  LoginDto({required this.username, required this.password});

  toJson() {
    return {"email": username, "password": password};
  }
}
