import 'package:flutter/material.dart';
import 'package:rha/src/config/config.dart';

class SubmitButton extends StatelessWidget {
  final Function submit;
  final String label;

  SubmitButton({super.key, required this.submit, required this.label});

  Size screenSize = AppConfig.getSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => submit(context),
      style: ButtonStyle(
          fixedSize: MaterialStateProperty.all<Size>(
              Size(screenSize.width * 0.95, screenSize.height * 0.07)),
          backgroundColor:
              MaterialStateProperty.all<Color>(AppColors.tallyColor),
          foregroundColor:
              MaterialStateProperty.all<Color>(AppColors.lightBackgroundColor),
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(screenSize.width * 0.02)))),
      child: Text(
        label,
        style: const TextStyle(color: AppColors.lightBackgroundColor),
      ),
    );
  }
}
