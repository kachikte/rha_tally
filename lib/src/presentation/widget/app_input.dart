import 'package:flutter/material.dart';
import 'package:rha/src/config/config.dart';
import 'package:rha/src/utils/utils.dart';

class AppInput extends StatelessWidget {
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
  final String label;
  final bool pinObscure;
  final TextInputType textInputType;
  final double paddingHorizontal;
  final double paddingVertical;
  final Color fillColor;

  AppInput(
      {required this.textEditingController,
        this.textInputType = TextInputType.text,
        required this.hintText,
        required this.errorText,
        this.enabled = true,
        this.icon = const SizedBox(),
        this.pinObscure = false,
        this.type = 'text',
        this.suffixIcon,
        this.isError = false,
        required this.width,
        required this.label,
        this.paddingHorizontal = 70,
        this.paddingVertical = 10,
        this.fillColor = AppColors.lightGrey,
        required this.height});

  @override
  Widget build(BuildContext context) {
    // final pinObscure = ref.watch(pinInputCompleteProvider);

    return SizedBox(
      child: Column(
        children: [
          label == ''
              ? const SizedBox()
              : Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: width,
            child: Text(
              label,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
          SizedBox(
            height: height * .01,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              obscureText: (type == Constants.passwordFieldType) && (pinObscure),
              enabled: enabled,
              keyboardType: textInputType,
              style: TextStyle(
                  color:
                  isError ? AppColors.appRed : AppColors.darkBackgroundColor),
              controller: textEditingController,
              cursorColor:
              isError ? AppColors.appRed : AppColors.darkBackgroundColor,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: fillColor.withOpacity(.4),
                  suffixIcon: suffixIcon,
                  suffixIconColor: AppColors.darkBackgroundColor,
                  prefixIcon: icon,
                  border: AppDecorations.borderOutline,
                  enabledBorder: isError
                      ? AppDecorations.borderError
                      : AppDecorations.borderOutline,
                  disabledBorder: AppDecorations.borderOutline,
                  hintText: hintText,
                  hintStyle: TextStyle(
                      color: AppColors.darkBackgroundColor.withOpacity(.4),
                      fontSize: 14),
                  contentPadding: EdgeInsets.symmetric(
                      vertical: paddingVertical, horizontal: paddingHorizontal),
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
            ),
          ),
          SizedBox(
            height: height * .02,
          ),
        ],
      ),
    );
  }
}
