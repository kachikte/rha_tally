import 'package:flutter/material.dart';
import 'package:rha/src/config/config.dart';

class NotificationRow extends StatelessWidget {
  final Size size;
  final Color circleColor;
  final String title;
  final String subTitle;
  final String image;

  const NotificationRow(
      {required this.size,
      required this.circleColor,
      required this.title,
      required this.subTitle,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      // height: size.height * .11,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: circleColor,
            child: Image.asset(image),
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width * .75,
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkBackgroundColor.withOpacity(.7)),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: size.width * .75,
                child: Text(
                  subTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 14,
                      color: AppColors.darkBackgroundColor.withOpacity(.5)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
