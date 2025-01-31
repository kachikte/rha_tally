import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final bool isSuffixText;
  final Color buttonColor;
  final Color borderColor;
  final Color? textColor;
  VoidCallback pressedFunction;
  final Widget buttonIcon;
  final Widget suffixButtonIcon;
  final String buttonText;
  final double buttonRadius;
  final double buttonHeight;

  AppButton(
      {super.key,
      required this.pressedFunction,
      this.buttonIcon = const SizedBox(),
      this.suffixButtonIcon = const SizedBox(),
      required this.buttonColor,
      required this.buttonText,
      this.textColor = Colors.black,
      this.borderColor = Colors.transparent,
      this.isSuffixText = false,
      this.buttonHeight = 60,
      this.buttonRadius = 30});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight, // Set your desired height here
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            side: BorderSide(
                color: borderColor, width: 1, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(buttonRadius),
          )),
          backgroundColor: MaterialStateProperty.all(buttonColor),
        ),
        onPressed: pressedFunction,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buttonIcon,
              if (buttonText != '')
                const SizedBox(
                  width: 10,
                ),
              if (buttonText != '')
                Text(
                  buttonText,
                  style: TextStyle(color: textColor),
                ),
              if (buttonText != '')
                const SizedBox(
                  width: 10,
                ),
              if (isSuffixText) const Expanded(child: SizedBox()),
              suffixButtonIcon,
            ],
          ),
        ),
      ),
    );
  }
}
