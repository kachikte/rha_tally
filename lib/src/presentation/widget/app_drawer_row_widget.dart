import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rha/src/config/config.dart';
import 'package:rha/src/presentation/controllers/controllers.dart';

class AppDrawerRowWidget extends StatelessWidget {
  final String image;
  final String name;
  final String route;
  final bool isActive;

  const AppDrawerRowWidget(
      {required this.image,
      required this.name,
      required this.route,
      required this.isActive});

  @override
  Widget build(BuildContext context) {
    GeneralController generalController = Get.find();

    return GestureDetector(
      onTap: () {
        generalController.selected = name.obs;
        Get.toNamed(route);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
        decoration: BoxDecoration(
            color: (isActive
                    ? AppColors.tallyColor
                    : AppColors.lightBackgroundColor)
                .withOpacity(.1),
            border: Border.all(
                color: isActive
                    ? AppColors.tallyColor
                    : AppColors.lightBackgroundColor,
                width: 1,
                style: BorderStyle.solid),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            Image.asset(image),
            const SizedBox(
              width: 20,
            ),
            Text(
              name,
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
      ),
    );
  }
}
