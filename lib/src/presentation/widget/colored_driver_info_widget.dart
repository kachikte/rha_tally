import 'package:flutter/material.dart';
import 'package:rha/src/config/config.dart';

class ColoredDriverInfoWidget extends StatelessWidget {
  final double width;
  final double height;
  final String name;
  final double rating;
  final String carType;
  final String carColor;
  final String plateNumber;
  final bool isIcons;

  const ColoredDriverInfoWidget(
      {required this.width,
      required this.height,
      this.isIcons = true,
      required this.name,
      required this.rating,
      required this.carType,
      required this.carColor,
      required this.plateNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      decoration: BoxDecoration(
          color: AppColors.lightGrey.withOpacity(.1),
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: Image.asset(
              AppImages.personJpg,
              width: 60,
              height: 60,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AppColors.lightBackgroundColor),
                  ),
                  const Icon(
                    Icons.star,
                    color: AppColors.tallyColor,
                  ),
                  Text(
                    rating.toString(),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.lightBackgroundColor.withOpacity(.3)),
                  ),
                ],
              ),
              Text(
                '$carType, $carColor',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: AppColors.lightBackgroundColor),
              ),
              Text(
                plateNumber,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: AppColors.lightBackgroundColor),
              )
            ],
          ),
          isIcons
              ? Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: AppColors.tallyColor,
                          style: BorderStyle.solid,
                          width: 1),
                      color: AppColors.appTransparent),
                  child: const Center(
                    child: Icon(
                      Icons.chat,
                      color: AppColors.tallyColor,
                      size: 30,
                    ),
                  ),
                )
              : const SizedBox(),
          isIcons
              ? Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: AppColors.tallyColor,
                          style: BorderStyle.solid,
                          width: 1),
                      color: AppColors.appTransparent),
                  child: const Center(
                    child: Icon(
                      Icons.phone,
                      color: AppColors.tallyColor,
                      size: 30,
                    ),
                  ),
                )
              : const SizedBox(
                  width: 150,
                ),
        ],
      ),
    );
  }
}
