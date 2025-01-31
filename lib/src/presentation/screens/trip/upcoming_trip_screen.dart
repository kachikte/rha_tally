import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rha/src/config/config.dart';
import 'package:rha/src/domain/domain.dart';
import 'package:rha/src/presentation/presentation.dart';

class UpcomingTripScreen extends StatefulWidget {

  final Map<String, dynamic> val;

  const UpcomingTripScreen({required this.val});

  @override
  _UpcomingTripScreenState createState() => _UpcomingTripScreenState();
}

class _UpcomingTripScreenState extends State<UpcomingTripScreen> {

  // TripController tripController = Get.find();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    log('The dets34543 - ${widget.val}');

    log('The detsfff32 - ${widget.val.isEmpty}');

    TripModel tripModel = widget.val['tripModel'];

    // log('The dets - ${tripController.bookedRide['ride']['tripCost']}');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.darkBackgroundColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: AppColors.lightBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          // height: size.height,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ride Summary Section
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Upcoming Ride',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Expanded(child: SizedBox()),
                ],
              ),
              RichText(
                text: TextSpan(
                  text: 'Pickup in: ', // Default text style
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColors.darkBackgroundColor,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '${double.parse(tripModel.duration.toString()).truncate()} mins',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.tallyColor,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(
                    Icons.circle_outlined,
                    color: AppColors.tallyColor,
                    size: 25,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    tripModel.startLocation,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(Icons.location_on_rounded,
                      color: AppColors.tallyColor),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      tripModel.endLocation,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  const Icon(Icons.calendar_today, color: AppColors.tallyColor),
                  const SizedBox(width: 8),
                  Text(
                    '${tripModel.startDate.split('kachTal')[0]} ${tripModel.startDate.split('kachTal')[1]}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Divider(
                height: 3,
                color: AppColors.darkBackgroundColor.withOpacity(.1),
                thickness: 5,
              ),
              const SizedBox(height: 24),

              Text(
                'Driver’s Details',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  const Icon(
                    Icons.circle_outlined,
                    color: AppColors.tallyColor,
                    size: 25,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Waiting for Driver to accept request',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.tallyColor,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Icon(
                    Icons.circle_outlined,
                    color: AppColors.lightGrey,
                    size: 25,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Ride request created',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              Text(
                'Payment Details',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 35),
              RowWidget(
                  height: size.height,
                  text1: 'Ride Fare',
                  isFirstBold: false,
                  text2: '₦${(double.parse(tripModel.amount.toString()) / 50).round() * 50}'),
              RowWidget(
                  height: size.height,
                  text1: 'Total',
                  isFirstBold: true,
                  text2: '₦${(double.parse(tripModel.amount.toString()) / 50).round() * 50}'),
              RowWidget(
                  height: size.height,
                  text1: 'Payment Method',
                  isFirstBold: false,
                  text2: tripModel.paymentStatus),
              const SizedBox(height: 35),

              // Pay Now Button
              AppButton(
                pressedFunction: () =>
                    Get.toNamed(AppRoutes.upcomingTripDriver),
                buttonColor: AppColors.tallyColor.withOpacity(.1),
                borderColor: AppColors.tallyColor,
                buttonText: 'Cancel Ride',
                buttonRadius: 10,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
