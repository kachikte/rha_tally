import 'package:get/get.dart';
import 'package:rha/src/presentation/presentation.dart';

class AppRoutes {
  static const onboarding = "/onboarding-screen";
  static const login = "/login-screen";
  static const signup = "/signup-screen";
  static const accountVerification = "/account-verification-screen";
  static const forgotPassword = "/forgot-password-screen";
  static const newPassword = "/new-password-screen";
  static const status = "/status-screen";
  static const locationChecker = "/location-checker-screen";
  static const scheduleRide = "/schedule-ride-screen";
  static const rideDestination = "/ride-destination-screen";
  static const locationMap = "/location-map-screen";
  static const selectRide = "/select-ride-screen";
  static const upcomingRide = "/upcoming-ride-screen";
  static const addCard = "/add-card-screen";
  static const addedCard = "/added-card-screen";
  static const upcomingTrip = "/upcoming-trip-screen";
  static const upcomingTripDriver = "/upcoming-trip-driver-screen";
  static const cancelRide = "/cancel-ride-screen";
  static const tripHistory = "/trip-history-screen";
  static const tripHistoryDetail = "/trip-history-detail-screen";
  static const chat = "/chat-screen";
  static const tripHome = "/trip-home-screen";
  static const tripStatus = "/trip-status-screen";
  static const tripRate = "/trip-rate-screen";
  static const payment = "/payment-screen";
  static const manageCards = "/manage-cards-screen";
  static const myCard = "/my-card-screen";
  static const withdrawFunds = "/withdraw-funds-screen";
  static const notification = "/notification-screen";
  static const reward = "/reward-screen";
  static const profile = "/profile-screen";
  static const changePassword = "/change-password-screen";
  static const legal = "/legal-screen";
  static const support = "/support-screen";
  static const privacyPolicy = "/privacy-policy-screen";
  static const deleteAccount = "/delete-account-screen";

  static routes() {
    return [
      GetPage(
        name: onboarding,
        page: () => const OnboardingScreen(),
      ),
      GetPage(
        name: login,
        page: () => LoginScreen(),
      ),
      GetPage(
        name: signup,
        page: () => SignUpScreen(),
      ),
      GetPage(
        name: accountVerification,
        page: () => AccountVerificationScreen(val: Get.arguments),
      ),
      GetPage(
        name: forgotPassword,
        page: () => const ForgotPasswordScreen(),
      ),
      GetPage(
        name: rideDestination,
        page: () => RideDestinationScreen(),
      ),
      GetPage(
        name: newPassword,
        page: () => const NewPasswordScreen(),
      ),
      GetPage(
        name: status,
        page: () => StatusScreen(val: Get.arguments),
      ),
      GetPage(
        name: locationChecker,
        page: () => LocationCheckerScreen(),
      ),
      GetPage(
        name: scheduleRide,
        page: () => ScheduleRideScreen(),
      ),
      GetPage(
        name: selectRide,
        page: () => SelectRideScreen(val: Get.arguments),
      ),
      GetPage(
        name: locationMap,
        page: () => LocationMapScreen(),
      ),
      GetPage(
        name: upcomingRide,
        page: () => UpcomingRideScreen(val: Get.arguments),
      ),
      GetPage(
        name: upcomingTrip,
        page: () => UpcomingTripScreen(val: Get.arguments,),
      ),
      GetPage(
        name: upcomingTripDriver,
        page: () => UpcomingTripDriverScreen(),
      ),
      GetPage(
        name: cancelRide,
        page: () => const CancelRideScreen(),
      ),
      GetPage(
        name: tripHistory,
        page: () => TripHistoryScreen(),
      ),
      GetPage(
        name: tripHistoryDetail,
        page: () => TripHistoryDetailScreen(val: Get.arguments),
      ),
      GetPage(
        name: tripHome,
        page: () => TripHomeScreen(),
      ),
      GetPage(
        name: tripStatus,
        page: () => TripStatusScreen(),
      ),
      GetPage(
        name: tripRate,
        page: () => const TripRateScreen(),
      ),
      GetPage(
        name: notification,
        page: () => NotificationScreen(),
      ),
      GetPage(
        name: profile,
        page: () => ProfileScreen(),
      ),
      GetPage(
        name: changePassword,
        page: () => const ChangePasswordScreen(),
      ),
    ];
  }
}
