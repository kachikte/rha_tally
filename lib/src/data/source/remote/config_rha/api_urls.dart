class ApiUrls {
  //Base URL definitions

  static const baseUrlLocal = "https://tally-core.onrender.com";
  static const baseUrlTest = "http://10.0.2.2:3000";
  static const baseUrlLive = "api.tallyride.com";
  static const url = baseUrlLocal;

  //Semi Base URL definitions
  // static const baseUrlV1 = "$url/customer/api/v1";
  // static const baseUrlV2 = "$url/customer/api/v2";

  //API URLs
  static const createAccount = "$url/auth/create-user";
  static const editOnline = "$url/users/edit-online";
  static const editLocation = "$url/users/edit-location";
  static const verifyOtp = "$url/auth/verify-otp";
  static const personalInfo = "$url/auth/driver-personal-info";
  static const driverOther = "$url/auth/driver-other-info";
  static const carDocuments = "$url/auth/car-documents";
  static const updateCarDocuments = "$url/users/update-car-documents";
  static const initForgotPassword = "$url/auth/init-forgot-password";
  static const forgotPassword = "$url/auth/forgot-password";
  static const login = "$url/auth/login";

  static const singleUpload = "$url/upload/single-file";
  static const getUserDetail = "$url/users/user-details";

  static const changePassword = "$url/users/change-password";
  static const createSupport = "$url/support/create-support";

  static const logout = "$url/users/logout";
  static const delete = "$url/users/delete-user";

  static const getDrivers = "$url/trips/driver-trip";

  static const createTrip = "$url/trips/create-trip";
  static const getTrips = "$url/trips";

}
