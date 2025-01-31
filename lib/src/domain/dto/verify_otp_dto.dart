class VerifyOtpDto {
  String? email;
  String? otp;

  VerifyOtpDto({required this.email, required this.otp});

  toJson() {
    return {"email": email, "otp": otp};
  }
}
