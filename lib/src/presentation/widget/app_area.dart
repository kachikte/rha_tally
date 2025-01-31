import 'package:flutter/material.dart';
import 'package:rha/src/config/config.dart';

class AppArea extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final String errorText;
  final bool enabled;
  final Widget? icon;
  final Widget? suffixIcon;
  final String type;
  final bool isError;
  final double height;
  final double width;
  final Widget label;
  final TextInputType textInputType;
  final String dropdownSelected;
  final Function(String?)? func;
  final List<String> dropdownItems;
  final int maxHeight;
  final Color fillColor;

  AppArea(
      {required this.textEditingController,
      this.textInputType = TextInputType.text,
      this.fillColor = Colors.white,
      required this.hintText,
      required this.errorText,
      this.enabled = true,
      this.icon = const SizedBox(),
      this.type = 'text',
      this.suffixIcon,
      this.isError = false,
      this.maxHeight = 5,
      required this.width,
      required this.label,
      this.dropdownSelected = 'select',
      this.dropdownItems = const ['select'],
      this.func,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: width,
            child: label,
          ),
          SizedBox(
            height: height * .01,
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                enabled: enabled,
                keyboardType: textInputType,
                maxLines: maxHeight,
                style: TextStyle(
                    color: isError ? AppColors.appRed : AppColors.darkBackgroundColor),
                controller: textEditingController,
                cursorColor: isError ? AppColors.appRed : AppColors.darkBackgroundColor,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: fillColor,
                    suffixIcon: suffixIcon,
                    suffixIconColor: AppColors.darkBackgroundColor,
                    prefix: icon,
                    border: AppDecorations.borderOutline,
                    enabledBorder: isError
                        ? AppDecorations.borderError
                        : AppDecorations.borderOutline,
                    disabledBorder: AppDecorations.borderOutline,
                    hintText: hintText,
                    hintStyle: TextStyle(
                        color: AppColors.darkBackgroundColor.withOpacity(.4),
                        fontSize: 14),
                    focusedBorder: isError
                        ? AppDecorations.borderError
                        : AppDecorations.borderOutline,
                    errorBorder: AppDecorations.borderError,
                    errorStyle: TextStyle(color: AppColors.appRed)),
                validator: (value) {
                  if (value == "") {
                    return errorText;
                  } else {
                    return null;
                  }
                },
              )),
          SizedBox(
            height: height * .02,
          ),
        ],
      ),
    );
  }
}
