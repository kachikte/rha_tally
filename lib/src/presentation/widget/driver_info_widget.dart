import 'package:flutter/material.dart';
import 'package:rha/src/config/config.dart';

class DriverInfoWidget extends StatelessWidget {
  final double width;
  final double height;
  final String name;
  final double rating;
  final String carType;
  final String carColor;
  final String plateNumber;
  final bool isIcons;

  const DriverInfoWidget(
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
    return SizedBox(
      height: height * .08,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            child: Image.asset(
              AppImages.securityUserPng,
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
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const Icon(
                    Icons.star,
                    color: AppColors.tallyColor,
                  ),
                  Text(
                    rating.toString(),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.darkBackgroundColor.withOpacity(.3)),
                  ),
                ],
              ),
              Text(
                '$carType, $carColor',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColors.darkBackgroundColor.withOpacity(.5)),
              ),
              Text(
                plateNumber,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: AppColors.darkBackgroundColor.withOpacity(.3)),
              )
            ],
          ),
          isIcons
              ? const CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.tallyColor,
                  child: CircleAvatar(
                    radius: 29,
                    backgroundColor: AppColors.lightBackgroundColor,
                    child: Center(
                      child: Icon(
                        Icons.chat,
                        color: AppColors.tallyColor,
                        size: 30,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          isIcons
              ? const CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.tallyColor,
                  child: CircleAvatar(
                    radius: 29,
                    backgroundColor: AppColors.lightBackgroundColor,
                    child: Center(
                      child: Icon(
                        Icons.phone,
                        color: AppColors.tallyColor,
                        size: 30,
                      ),
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
