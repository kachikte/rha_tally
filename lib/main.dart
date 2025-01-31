import 'dart:async';
import 'dart:developer';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:rha/src/config/config.dart';
import 'package:rha/src/data/data.dart';
import 'package:rha/src/init_controllers.dart';
import 'package:rha/src/presentation/controllers/general_controller.dart';
import 'package:rha/src/utils/utils.dart';
import 'package:upgrader/upgrader.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  GeneralController.initialToken =
      await SecuredStorage.readData(key: StoredKeys.TOKEN);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    getDeviceId();
  }

  Future<void> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String id;

    try {
      if (Theme.of(context).platform == TargetPlatform.android) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        id = androidInfo.id; // Unique device ID
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        id = iosInfo.identifierForVendor ?? "Unknown"; // Unique device ID
      } else {
        id = "Unsupported Platform";
      }
    } catch (e) {
      id = "Error: ${e.toString()}";
    }

    Constants.deviceId = id;

    // setState(() {
    //   deviceId = id;
    // });
  }

  // void initializeSocket() {
  //   socket = IO.io(ApiUrls.baseUrlTest, <String, dynamic>{
  //     'transports': ['websocket'],
  //     'autoConnect': true,
  //   });
  //
  //   socket.onConnect((_) {
  //     log('Connected to server');
  //
  //     // Register user ID (replace '12345' with dynamic user ID)
  //     socket.emit('register', '12345');
  //   });
  //
  //   socket.on('message', (data) {
  //     log('New message: $data');
  //     setState(() {
  //       messages.add(data);
  //     });
  //     // UtilFunctions.showTopSnackSuccess(context, data);
  //     Get.snackbar(data, data);
  //   });
  //
  //   socket.onDisconnect((_) {
  //     log('Disconnected from server');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    InitControllers();
    return GlobalLoaderOverlay(
      overlayColor: Colors.transparent,
      child: OverlaySupport(
          child: UpgradeAlert(
        child: GetMaterialApp(
          initialRoute: AppRoutes.onboarding,
          title: AppConstants.TITLE,
          theme: AppTheme.lightTheme(),
          darkTheme: AppTheme.darkTheme(),
          themeMode: AppTheme.themeMode(isLight: true),
          getPages: AppRoutes.routes(),
          debugShowCheckedModeBanner: false,
        ),
      )),
    );
  }
}
