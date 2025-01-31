import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rha/src/config/config.dart';
import 'package:rha/src/presentation/presentation.dart';
import 'package:rha/src/utils/form_utils/app_check_box.dart';

class CancelRideScreen extends StatefulWidget {
  const CancelRideScreen({Key? key}) : super(key: key);

  @override
  State<CancelRideScreen> createState() => _CancelRideScreenState();
}

class _CancelRideScreenState extends State<CancelRideScreen> {
  bool isSet = false;

  TextEditingController reasonController = TextEditingController();

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
                    'Cancel Ride',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Expanded(child: SizedBox()),
                ],
              ),
              Text(
                'Select reason for cancelling the ride',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w400),
              ),

              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppCheckBox(
                      checkColor: AppColors.darkBackgroundColor,
                      isRememberMe: isSet,
                      setIsRememberMe: (val) {
                        setState(() {
                          isSet = !isSet;
                        });
                      }),
                  Text(
                    'Waiting for long time',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w400),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppCheckBox(
                      checkColor: AppColors.darkBackgroundColor,
                      isRememberMe: isSet,
                      setIsRememberMe: (val) {
                        setState(() {
                          isSet = !isSet;
                        });
                      }),
                  Text(
                    'Accidental request',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w400),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppCheckBox(
                      checkColor: AppColors.darkBackgroundColor,
                      isRememberMe: isSet,
                      setIsRememberMe: (val) {
                        setState(() {
                          isSet = !isSet;
                        });
                      }),
                  Text(
                    'Unable to contact driver',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w400),
                  )
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppCheckBox(
                      checkColor: AppColors.darkBackgroundColor,
                      isRememberMe: isSet,
                      setIsRememberMe: (val) {
                        setState(() {
                          isSet = !isSet;
                        });
                      }),
                  Text(
                    'Driver refused to go to destination',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w400),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppCheckBox(
                      checkColor: AppColors.darkBackgroundColor,
                      isRememberMe: isSet,
                      setIsRememberMe: (val) {
                        setState(() {
                          isSet = !isSet;
                        });
                      }),
                  Text(
                    'Driver refused to come to pickup',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w400),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppCheckBox(
                      checkColor: AppColors.darkBackgroundColor,
                      isRememberMe: isSet,
                      setIsRememberMe: (val) {
                        setState(() {
                          isSet = !isSet;
                        });
                      }),
                  Text(
                    'Wrong address',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w400),
                  )
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppCheckBox(
                      checkColor: AppColors.darkBackgroundColor,
                      isRememberMe: isSet,
                      setIsRememberMe: (val) {
                        setState(() {
                          isSet = !isSet;
                        });
                      }),
                  Text(
                    'The price is not reasonable',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(fontWeight: FontWeight.w400),
                  )
                ],
              ),

              AppArea(
                  fillColor: AppColors.lightGrey.withOpacity(.2),
                  textEditingController: reasonController,
                  hintText: 'Other reasons',
                  errorText: '',
                  width: size.width,
                  label: const SizedBox(),
                  height: size.height),

              // Pay Now Button
              AppButton(
                pressedFunction: () =>
                    Get.toNamed(AppRoutes.status, arguments: {
                  'text': 'Your Ride has been cancelled',
                  'icon': Image.asset(AppImages.tallyCryingPng),
                  'buttonText': 'Back Home',
                  'function': AppRoutes.tripHistory
                }),
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
