import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rha/src/config/config.dart';
import 'package:rha/src/presentation/presentation.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  TripController tripController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.darkBackgroundColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: AppColors.tallyColor,
        elevation: 0,
      ),
      backgroundColor: AppColors.lightBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              width: size.width,
              decoration: const BoxDecoration(color: AppColors.tallyColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Notifications',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Text(
                'Today',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: NotificationRow(
                  size: size,
                  title: '20% Special Discount!',
                  subTitle:
                      'Get 20% off your next ride when you use the code: RTYH655',
                  circleColor: AppColors.tallyColor,
                  image: AppImages.giftLightPng),
            ),
            GestureDetector(
              onTap: () {},
              child: NotificationRow(
                  size: size,
                  title: 'Card added successfully',
                  subTitle: 'Your new card has been added successfully',
                  circleColor: AppColors.lightGrey,
                  image: AppImages.cardAddPng),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Text(
                'Yesterday',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: NotificationRow(
                  size: size,
                  title: 'Wallet funded',
                  subTitle:
                      'Your wallet has been funded via your virtual account',
                  circleColor: AppColors.lightGrey,
                  image: AppImages.walletLightPng),
            ),
            GestureDetector(
              onTap: () {},
              child: NotificationRow(
                  size: size,
                  title: '20% Special Discount!',
                  subTitle:
                      'Get 20% off your next ride when you use the code: RTYH655',
                  circleColor: AppColors.lightGrey,
                  image: AppImages.giftLightPng),
            ),
            GestureDetector(
              onTap: () {},
              child: NotificationRow(
                  size: size,
                  title: 'Card added successfully',
                  subTitle: 'Your new card has been added successfully',
                  circleColor: AppColors.tallyColor,
                  image: AppImages.cardAddPng),
            ),
            GestureDetector(
              onTap: () {},
              child: NotificationRow(
                  size: size,
                  title: '5% Special Discount!',
                  subTitle:
                      'Get 20% off your next ride when you use the code: RTYH655',
                  circleColor: AppColors.tallyColor,
                  image: AppImages.giftLightPng),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: Text(
                'Yesterday',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: NotificationRow(
                  size: size,
                  title: '5% Special Discount!',
                  subTitle:
                      'Get 20% off your next ride when you use the code: RTYH655',
                  circleColor: AppColors.lightGrey,
                  image: AppImages.giftLightPng),
            ),
          ],
        ),
      ),
    );
  }
}
