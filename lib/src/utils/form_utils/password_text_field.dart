import 'package:flutter/material.dart';
import 'package:rha/src/config/config.dart';

class PasswordTextField extends StatelessWidget {
  late TextEditingController textEditingController;
  final String hintText;
  final String errorText;
  late bool obscureValue;
  VoidCallback setObscure;

  PasswordTextField(
      {super.key,
      required this.textEditingController,
      required this.hintText,
      required this.errorText,
      required this.obscureValue,
      required this.setObscure});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      controller: textEditingController,
      decoration: InputDecoration(
        filled: true, // Set to true to fill the TextField's background
        fillColor: AppColors.lightGrey,
        // border: AppDecorations.borderOutline,
        enabledBorder: AppDecorations.borderOutline,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        focusedBorder: AppDecorations.borderOutline,
        errorBorder: AppDecorations.borderError,
        errorStyle: const TextStyle(color: AppColors.tallyColor),
        suffixIcon: IconButton(
          icon: obscureValue
              ? const Icon(
                  Icons.remove_red_eye,
                  color: Colors.white,
                )
              : const Icon(
                  Icons.remove_red_eye_outlined,
                  color: Colors.white,
                ),
          onPressed: setObscure,
        ),
      ),
      obscureText: obscureValue,
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
