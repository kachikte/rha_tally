class LoginModel {
  //Receive data from API

  late String accessToken;
  late String authorization;

  LoginModel.fromJson({required json}) {
    accessToken = json["token"];
    // authorization = json["authorization"];
    authorization = "Bearer";
  }

  LoginModel.fromWorkplace({required json}) {
    accessToken = json["token"];
    authorization = "Bearer";
  }
}
