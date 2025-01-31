import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rha/src/config/config.dart';
import 'package:rha/src/presentation/presentation.dart';
import 'package:rha/src/utils/utils.dart';

class AppDrawerWidget extends StatelessWidget {
  const AppDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.find();

    GeneralController generalController = Get.find();
    Size size = MediaQuery.of(context).size;

    return Drawer(
      backgroundColor: AppColors.lightBackgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: size.height * .3,
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(color: AppColors.tallyColor),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * .17,
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.profile),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: AppColors.darkBackgroundColor,
                        child: ClipRRect(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(28)),
                          child: Image.network(
                            profileController.appUserModel.imageUrl
                                .value, // Replace with your actual image URL
                            width: 45,
                            height: 45,
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(
                                Icons.error,
                                color: Colors.red,
                                size: 45,
                              ); // Show an error icon if the image fails to load
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return CircularProgressIndicator(); // Show a loading spinner while the image is loading
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${profileController.appUserModel.lastName.value} ${profileController.appUserModel.firstName.value}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rate_rounded,
                                color: AppColors.lightBackgroundColor,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '4.8',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          Text(
                            'My Profile',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                fontWeight: FontWeight.w300,
                                decoration: TextDecoration.underline),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          AppDrawerRowWidget(
              image: AppImages.securityUserPng,
              name: Constants.home,
              route: AppRoutes.locationChecker,
              isActive:
              generalController.selected.value == Constants.home),
          AppDrawerRowWidget(
              image: AppImages.ridePng,
              name: Constants.myRides,
              route: AppRoutes.tripHistory,
              isActive: generalController.selected.value == Constants.myRides),
          AppDrawerRowWidget(
              image: AppImages.notificationPng,
              name: Constants.notifications,
              route: AppRoutes.notification,
              isActive:
              generalController.selected.value == Constants.notifications),
        ],
      ),
    );
  }
}
