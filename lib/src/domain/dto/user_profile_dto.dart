class UserProfileDto {
  final String phoneNumber;
  final String countryCode;
  final String firstName;
  final String lastName;
  final String streetNumber;
  final String streetName;
  final String city;
  final String map;
  final String state;
  final String country;

  UserProfileDto(
      {required this.phoneNumber,
      required this.countryCode,
      required this.firstName,
      required this.lastName,
      required this.streetNumber,
      required this.streetName,
      required this.city,
      required this.map,
      required this.state,
      required this.country});
}
