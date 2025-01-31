import 'package:flutter/material.dart';
import 'package:rha/src/config/config.dart';

class RowWidget extends StatelessWidget {
  final double height;
  final String text1;
  final bool isFirstBold;
  final String text2;

  const RowWidget(
      {required this.height,
      required this.text1,
      required this.isFirstBold,
      required this.text2});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * .06,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text1,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight:
                        isFirstBold ? FontWeight.w600 : FontWeight.w400),
              ),
              Text(
                text2,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Divider(
            color: AppColors.darkBackgroundColor.withOpacity(.5),
          ),
        ],
      ),
    );
  }
}
