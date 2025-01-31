import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rha/src/config/config.dart';
import 'package:rha/src/domain/domain.dart';
import 'package:rha/src/presentation/presentation.dart';

class TripHistoryDetailScreen extends StatefulWidget {

  final Map<String, dynamic> val;

  const TripHistoryDetailScreen({required this.val});

  @override
  _TripHistoryDetailScreenState createState() =>
      _TripHistoryDetailScreenState();
}

class _TripHistoryDetailScreenState extends State<TripHistoryDetailScreen> {
  @override
  Widget build(BuildContext context) {

    TripModel tripModel = widget.val['trip'];

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
                    'Ride History',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Expanded(child: SizedBox()),
                ],
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
                    tripModel.startDate.trim().split('kachTal')[0],
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

              DriverInfoWidget(
                  width: size.width,
                  isIcons: false,
                  height: size.height,
                  name: 'Adeyemi',
                  rating: 4.9,
                  carType: 'Toyota Camry',
                  carColor: 'Gold',
                  plateNumber: 'RSH01AS'),
              const SizedBox(height: 25),

              Text(
                'Payment Details',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 25),
              RowWidget(
                  height: size.height,
                  text1: 'Ride Fare',
                  isFirstBold: false,
                  text2: '₦${(tripModel.amount / 50).round() * 50}'),
              RowWidget(
                  height: size.height,
                  text1: 'Total',
                  isFirstBold: true,
                  text2: '₦${(tripModel.amount / 50).round() * 50}'),
              RowWidget(
                  height: size.height,
                  text1: 'Payment Method',
                  isFirstBold: false,
                  text2: tripModel.paymentStatus),
              const SizedBox(height: 25),

              // Pay Now Button
              AppButton(
                pressedFunction: () => Get.toNamed(AppRoutes.support),
                buttonColor: AppColors.tallyColor.withOpacity(.1),
                borderColor: AppColors.tallyColor,
                buttonText: 'Issues with Trip',
                buttonRadius: 10,
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.upload_rounded),
                  Text(
                    'Download Receipt',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.underline),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
