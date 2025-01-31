import 'package:get/get.dart';
import 'package:rha/src/data/data.dart';
import 'package:rha/src/domain/domain.dart';

class NotificationController extends GetxController {

  AppDBNotifications appDBNotifications = AppDBNotifications();

  RxInt notificationCount = 0.obs;
  RxInt newNotificationCount = 0.obs;
  RxBool newNotification = false.obs;

  List<AppNotificationModel> appNotifications = [];

  setNotificationsLocal() async {
    appNotifications = await appDBNotifications.getNotifications();
  }
}
