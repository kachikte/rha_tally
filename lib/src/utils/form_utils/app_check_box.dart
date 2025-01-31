import 'package:flutter/material.dart';
import 'package:rha/src/config/config.dart';

class AppCheckBox extends StatelessWidget {
  Size screenSize = AppConfig.getSize;

  late bool isRememberMe;
  late Color checkColor;
  void Function(bool?)? setIsRememberMe;

  AppCheckBox(
      {super.key,
      required this.isRememberMe,
      required this.setIsRememberMe,
      required this.checkColor});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isRememberMe,
      onChanged: setIsRememberMe,
      activeColor: Colors.blue,
      fillColor: MaterialStateProperty.all<Color>(
          isRememberMe ? checkColor : AppColors.lightBackgroundColor),
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(screenSize.width * 0.01))),
      side: BorderSide(
          width: screenSize.height * 0.001,
          style: BorderStyle.solid,
          color: AppColors.darkBackgroundColor),
    );
  }
}
