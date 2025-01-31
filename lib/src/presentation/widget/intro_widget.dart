import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rha/src/config/config.dart';

class IntroWidget extends StatelessWidget {
  const IntroWidget({
    super.key,
    required this.color,
    required this.title,
    required this.description,
    required this.skip,
    required this.image,
    required this.onTab,
    required this.widget,
    required this.index,
  });

  final String color;
  final String title;
  final String description;
  final bool skip;
  final String image;
  final VoidCallback onTab;
  final int index;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.lightBackgroundColor,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: AppConfig.getSize.height * .15,
                bottom: AppConfig.getSize.height * .05),
            child: SvgPicture.asset(
              image,
              semanticsLabel: 'Tally Onboarding',
              width: AppConfig.getSize.width * .5,
              height: AppConfig.getSize.height * .4,
            ),
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.w500, fontSize: 20, wordSpacing: 3),
          ),
          const Expanded(child: SizedBox()),
          Container(
            // margin: EdgeInsets.only(top: AppConfig.getSize.height * .1),
            height: AppConfig.getSize.height * .2,
            child: widget,
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
