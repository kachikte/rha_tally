import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rha/src/config/config.dart';
import 'package:rha/src/presentation/presentation.dart';

class UpcomingTripDriverScreen extends StatefulWidget {
  @override
  _UpcomingTripDriverScreenState createState() =>
      _UpcomingTripDriverScreenState();
}

class _UpcomingTripDriverScreenState extends State<UpcomingTripDriverScreen> {
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
                text: const TextSpan(
                  text: 'Pickup in: ', // Default text style
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.darkBackgroundColor,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '10 mins',
                      style: TextStyle(
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
                    'No. 5, 85th Street',
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
                      'Vintage Hub, 135 Adetokunbo Ademola Crescent, Abuja',
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
                    'Sat 17 Feb at 3:10 PM - 3:15 PM GMT+1',
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
                  height: size.height,
                  name: 'Adeyemi',
                  rating: 4.9,
                  carType: 'Toyota Camry',
                  carColor: 'Gold',
                  plateNumber: 'RSH01AS'),
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
                  text2: '₦2500'),
              RowWidget(
                  height: size.height,
                  text1: 'Total',
                  isFirstBold: true,
                  text2: '₦2500'),
              RowWidget(
                  height: size.height,
                  text1: 'Payment Method',
                  isFirstBold: false,
                  text2: 'Card'),
              const SizedBox(height: 35),

              // Pay Now Button
              AppButton(
                pressedFunction: () => Get.toNamed(AppRoutes.cancelRide),
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
