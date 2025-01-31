import 'dart:developer';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rha/src/config/app_colors.dart';
import 'package:rha/src/config/app_images.dart';
import 'package:rha/src/config/app_routes.dart';
import 'package:rha/src/domain/domain.dart';
import 'package:rha/src/presentation/presentation.dart';
import 'package:rha/src/utils/util_functions.dart';

class UpcomingRideScreen extends StatefulWidget {
  final Map<String, dynamic> val;

  const UpcomingRideScreen({required this.val});

  @override
  _UpcomingRideScreenState createState() => _UpcomingRideScreenState();
}

class _UpcomingRideScreenState extends State<UpcomingRideScreen> {
  TripController tripController = Get.find();

  void showModal(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          content: SizedBox(
            height: height * .25,
            width: width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(height: 16),
                // Title text
                const Text(
                  'Schedule Ride',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // Description text
                Text(
                  'You are about to schedule an upcoming trip',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),
                // Enable Location button
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                          buttonHeight: 50,
                          buttonRadius: 10,
                          pressedFunction: () async {
                            Navigator.of(context).pop();
                          },
                          buttonColor: AppColors.lightBackgroundColor,
                          buttonText: 'Cancel'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: AppButton(
                          buttonHeight: 50,
                          buttonRadius: 10,
                          pressedFunction: tripController
                                      .selectedPaymentMethod.value ==
                                  ''
                              ? () {}
                              : () async {
                                  CreateTripDto createTripDto = CreateTripDto(
                                      driverId: widget.val['ride']['driver']
                                          ['id'],
                                      status: 'pending',
                                      startLocation:
                                          widget.val['originAddress'],
                                      endLocation:
                                          widget.val['destinationAddress'],
                                      duration: widget.val['ride']['tripTime'],
                                      distance: widget.val['ride']
                                          ['tripDistance'],
                                      paymentStatus: 'pending',
                                      startDate: '${tripController.scheduledDate.value}kachTal${tripController.scheduledTime.value}',
                                      amount: double.parse(widget.val['ride']['tripCost']),
                                      endDate: DateTime.now().toString(),
                                      rideType: widget.val['ride']['driver']
                                          ['carType'],
                                      tripType:
                                          tripController.rideSchedule.value);

                                  ResponseModel responseModel = await tripController.createTrip(createTripDto: createTripDto);
                                  if (responseModel.isError) {
                                    UtilFunctions.showTopSnackError(context, 'Could not process your request');
                                  } else {
                                    Get.toNamed(AppRoutes.status, arguments: {
                                      'remv': true,
                                      'text': 'Ride Scheduled Successfully',
                                      'icon': const CircleAvatar(
                                        radius: 62,
                                        backgroundColor: AppColors.appGreen,
                                        child: CircleAvatar(
                                          radius: 61,
                                          backgroundColor:
                                          AppColors.lightBackgroundColor,
                                          child: CircleAvatar(
                                            radius: 56,
                                            backgroundColor: AppColors.appGreen,
                                            child: CircleAvatar(
                                              radius: 55,
                                              backgroundColor:
                                              AppColors.lightBackgroundColor,
                                              child: CircleAvatar(
                                                radius: 50,
                                                backgroundColor:
                                                AppColors.appGreen,
                                                child: Icon(
                                                  Icons.check,
                                                  size: 50,
                                                  color: AppColors
                                                      .lightBackgroundColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // 'function': AppRoutes.upcomingTrip
                                      'function': AppRoutes.locationChecker
                                    });
                                  }
                                },
                          buttonColor: AppColors.tallyColor,
                          buttonText: 'Confirm'),
                    )
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  String convertTimeOfDayToString(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('hh:mm a').format(dt); // 'hh:mm a' for 12-hour format with AM/PM
  }

  TimeOfDay stringToTimeOfDay(String timeString) {
    final parts = timeString.split(":");
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    return TimeOfDay(hour: hour, minute: minute);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    log('This is the upcoming ride - ${widget.val}');

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Upcoming Ride',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const Expanded(child: SizedBox()),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Edit',
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColors.tallyColor,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Icon(
                    size: 16,
                    Icons.edit,
                    color: AppColors.tallyColor,
                  )
                ],
              ),

              const Text('View your trip summary',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),

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
                    widget.val['originAddress'],
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
                      widget.val['destinationAddress'],
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
                    // 'Sat 17 Feb at 3:10 PM - 3:15 PM GMT+1',
                    '${tripController.scheduledDate.value.split(' ')[0]}',
                    // '${tripController.scheduledDate.value.split(' ')[0]} ${convertTimeOfDayToString(stringToTimeOfDay(tripController.scheduledTime.value))}',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w300),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  text: 'Total Fare: ', // Default text style
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          '₦${(double.parse(widget.val['ride']['tripCost'].toString()) / 50).round() * 50}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.tallyColor,
                      ),
                    ),
                    TextSpan(
                      text: '  (estimated)',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Divider(
                height: 3,
                color: AppColors.darkBackgroundColor.withOpacity(.1),
                thickness: 5,
              ),
              const SizedBox(height: 24),

              // Payment Method Section
              Text(
                'Payment Method',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              Text(
                'Select a payment method for your trip',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w300),
              ),
              const SizedBox(height: 16),

              // Wallet Payment Option
              GestureDetector(
                onTap: () {
                  setState(() {
                    tripController.selectedPaymentMethod.value = 'wallet';
                  });
                },
                child: paymentOptionCard(
                  'My Wallet',
                  '₦5500',
                  AppImages.walletPng,
                  tripController.selectedPaymentMethod.value == 'wallet',
                ),
              ),
              const SizedBox(height: 8),

              // Bank Transfer Payment Option
              GestureDetector(
                onTap: () {
                  setState(() {
                    tripController.selectedPaymentMethod.value = 'bank';
                  });
                },
                child: paymentOptionCard(
                  'Bank Transfer',
                  '',
                  AppImages.bankPng,
                  tripController.selectedPaymentMethod.value == 'bank',
                ),
              ),
              const SizedBox(height: 8),

              // Add Card Payment Option
              tripController.addedCard.value
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          tripController.selectedPaymentMethod.value = 'card';
                        });
                      },
                      child: paymentOptionCard(
                        '**** **** **** 8970',
                        'Expires: 12/26',
                        AppImages.mastercardPng,
                        tripController.selectedPaymentMethod.value == 'card',
                      ),
                    )
                  : SizedBox(
                      height: 60,
                      child: AppButton(
                        pressedFunction: () => Get.toNamed(AppRoutes.addCard,
                            arguments: {'isTrip': 'true', 'ride': widget.val}),
                        buttonColor: AppColors.tallyColor.withOpacity(.1),
                        buttonText: 'Add Card Payment',
                        buttonRadius: 10,
                        buttonIcon: const Icon(
                          Icons.add,
                          color: AppColors.darkBackgroundColor,
                        ),
                        borderColor: AppColors.tallyColor,
                      ),
                    ),
              const SizedBox(height: 35),

              // Pay Now Button
              AppButton(
                pressedFunction: () => showModal(context),
                buttonColor: tripController.selectedPaymentMethod.value == ''
                    ? AppColors.lightGrey
                    : AppColors.tallyColor,
                buttonText: 'Pay Now',
                buttonRadius: 10,
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget paymentOptionCard(
    String title,
    String subtitle,
    String image,
    bool isSelected,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? AppColors.tallyColor : AppColors.lightGrey,
          width: 1,
        ),
      ),
      child: ListTile(
        leading: Image.asset(image),
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.w400),
        ),
        subtitle: subtitle.isNotEmpty
            ? Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w300,
                    color: AppColors.darkBackgroundColor),
              )
            : null,
      ),
    );
  }
}
