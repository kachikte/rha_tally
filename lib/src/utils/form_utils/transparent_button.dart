import 'package:flutter/material.dart';


class TransparentButton extends StatelessWidget {
  final double fixedWidth;
  final double fixedHeight;
  final Size size;
  final String label;
  final VoidCallback function;
  final Color borderColor;
  final Color backgroundColor;
  final Color textColor;

  const TransparentButton(
      {super.key, required this.fixedHeight,
      required this.fixedWidth,
      required this.size,
      required this.function,
      required this.label,
      required this.textColor,
      required this.borderColor,
      required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: fixedWidth,
        child: ElevatedButton(
            onPressed: function,
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all<Size>(
                  Size(fixedWidth, fixedHeight)),
              backgroundColor:
                  MaterialStateProperty.all<Color>(backgroundColor),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(size.width * 0.02),
                      side: BorderSide(
                          color: borderColor,
                          style: BorderStyle.solid,
                          width: size.width * 0.004))),
            ),
            child: Text(label, style: TextStyle(color: textColor))));
  }
}
