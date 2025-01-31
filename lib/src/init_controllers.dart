import 'package:get/get.dart';
import 'package:rha/src/presentation/controllers/controllers.dart';
import 'package:rha/src/presentation/controllers/notification_controller.dart';

class InitControllers {
  InitControllers() {
    NotificationController notificationController =
    Get.put(NotificationController());
    ProfileController profileController = Get.put(ProfileController());
    GeneralController generalController = Get.put(GeneralController());
    OnboardingController onboardingController = Get.put(OnboardingController());
    SignupController signupController = Get.put(SignupController());
    LoginController loginController = Get.put(LoginController());
    TripController tripController = Get.put(TripController());
  }
}
