import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppConfig {

  //This is way bigger than MediaQuery.of(context).size
  static Size screenSize = WidgetsBinding.instance.window.physicalSize;

  //This is a little bit smaller than MediaQuery.of(context).size
  static Size getSize = Get.size;

  static Size screenSz({required BuildContext context}) {
    return MediaQuery.of(context).size;
  }
}