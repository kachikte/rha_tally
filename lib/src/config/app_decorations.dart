import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_config.dart';

class AppDecorations {

  static double borderRadiusCircular = AppConfig.screenSize.width * 0.01;

  static OutlineInputBorder borderOutline = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(borderRadiusCircular)),
      borderSide: const BorderSide(
          color: AppColors.lightGrey, width: 0.4, style: BorderStyle.solid));

  static OutlineInputBorder borderError = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(borderRadiusCircular)),
      borderSide: const BorderSide(
          color: AppColors.lightGrey, width: 0.4, style: BorderStyle.solid));

  static focusedBorder({required double width}) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(width * 0.02)),
        borderSide: const BorderSide(
            color: AppColors.darkBackgroundColor,
            width: 0.7,
            style: BorderStyle.solid));
  }

}