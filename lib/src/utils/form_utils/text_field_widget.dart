import 'package:flutter/material.dart';
import 'package:rha/src/config/config.dart';

class TextFieldWidget extends StatelessWidget {
  late TextEditingController textEditingController;
  final String hintText;
  final String errorText;
  final bool enabled;

  TextFieldWidget(
      {super.key,
      required this.textEditingController,
      required this.hintText,
      required this.errorText,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      style: const TextStyle(color: AppColors.darkBackgroundColor),
      controller: textEditingController,
      cursorColor: AppColors.darkBackgroundColor,
      decoration: InputDecoration(
          filled: true, // Set to true to fill the TextField's background
          fillColor: AppColors.lightGrey,
          border: AppDecorations.borderOutline,
          enabledBorder: AppDecorations.borderOutline,
          disabledBorder: AppDecorations.borderOutline,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white),
          focusedBorder: AppDecorations.borderOutline,
          errorBorder: AppDecorations.borderError,
          errorStyle: const TextStyle(color: AppColors.tallyColor)),
      validator: (value) {
        if (value == "") {
          return errorText;
        } else {
          return null;
        }
      },
    );
  }
}
