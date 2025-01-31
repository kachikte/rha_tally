import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rha/src/config/config.dart';
import 'package:rha/src/presentation/presentation.dart';
import 'package:rha/src/utils/utils.dart';

class SelectRideScreen extends StatefulWidget {
  final Map<String, dynamic> val;

  const SelectRideScreen({required this.val});

  @override
  _SelectRideScreenState createState() => _SelectRideScreenState();
}

class _SelectRideScreenState extends State<SelectRideScreen> {
  late GoogleMapController _mapController;
  TripController tripController = Get.find();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  final LatLng _initialPosition =
      LatLng(37.7749, -122.4194); // Default coordinates

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    log('This is the sseen ride - ${widget.val['ride']}');

    return Scaffold(
      drawer: const AppDrawerWidget(),
      body: Stack(
        children: [
          // Google Map Background
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 14.0,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
          ),
          // Bottom ride scheduling section
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height * .5,
              decoration: const BoxDecoration(
                color: AppColors.darkBackgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Select a Ride',
                      style: TextStyle(
                        color: AppColors.lightBackgroundColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Obx(() => widget.val['ride'] == '' ? const SizedBox(
                    child: Text('No rides available',style: TextStyle(color: AppColors.lightBackgroundColor),),
                  ): Row(
                        mainAxisAlignment:
                            (((widget.val['ride']['tally'] as Map).isEmpty) ||
                                    ((widget.val['ride']['luxury'] as Map)
                                        .isEmpty))
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              tripController.carType.value =
                                  Constants.tallyRide;
                            },
                            child: (widget.val['ride']['tally'] as Map).isEmpty
                                ? const SizedBox()
                                : rideOption(
                                    height,
                                    width * .45,
                                    Constants.tallyRide,
                                    '₦${(double.parse(widget.val['ride']['tally']['tripCost'].toString()) / 50).round() * 50}',
                                    '4',
                                    '${double.parse(widget.val['ride']['tally']['tripTime'].toString()).truncate()} mins',
                                    AppImages.carLightPng,
                                    tripController.carType.value ==
                                        Constants.tallyRide),
                          ),
                          GestureDetector(
                            onTap: () {
                              tripController.carType.value =
                                  Constants.luxuryRide;
                            },
                            child: (widget.val['ride']['luxury'] as Map).isEmpty
                                ? const SizedBox()
                                : rideOption(
                                    height,
                                    width * .45,
                                    Constants.luxuryRide,
                                    '₦${(double.parse(widget.val['ride']['luxury']['tripCost'].toString()) / 50).round() * 50}',
                                    '4',
                                    '${double.parse(widget.val['ride']['luxury']['tripTime'].toString()).truncate()} mins',
                                    AppImages.carTallyPng,
                                    tripController.carType.value ==
                                        Constants.luxuryRide),
                          ),
                        ],
                      )),
                  const SizedBox(height: 16),
                  Obx(() => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        child: AppButton(
                          buttonRadius: 10,
                          pressedFunction: tripController.carType.value == ''
                              ? () {
                            Get.toNamed(AppRoutes.locationChecker);
                          }
                              : () {
                                  tripController.bookedRide = {
                                    'ride': tripController.carType.value ==
                                            Constants.luxuryRide
                                        ? widget.val['ride']['luxury']
                                        : widget.val['ride']['tally'],
                                    'originAddress': widget.val['ride']
                                        ['originAddress'],
                                    'destinationAddress': widget.val['ride']
                                        ['destinationAddress'],
                                  };

                                  Get.toNamed(AppRoutes.upcomingRide,
                                      arguments: tripController.bookedRide);
                                },
                          textColor: tripController.carType.value == ''
                              ? AppColors.lightBackgroundColor
                              : AppColors.darkBackgroundColor,
                          buttonColor: tripController.carType.value == ''
                              ? AppColors.lightGrey.withOpacity(.2)
                              : AppColors.tallyColor,
                          buttonText: 'Next',
                          buttonHeight: 50,
                        ),
                      )),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          // Top navigation buttons
          Positioned(
            top: 50,
            left: 16,
            child: Builder(
              builder: (context) {
                return CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: AppColors.darkBackgroundColor,
                      size: 25,
                    ),
                    onPressed: () {
                      Scaffold.of(context)
                          .openDrawer(); // Use Scaffold.of(context) inside Builder
                    },
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 50,
            right: 16,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.car_rental, color: Colors.black),
                    onPressed: () {
                      // Notification button action
                      Get.toNamed(AppRoutes.tripHistory);
                    },
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Obx(() => CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.yellow[700],
                      child:  Text(
                        tripController.unCompletedTrips.value.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget rideOption(double height, double width, String title, String price,
    String rating, String eta, String imagePath, bool isSelected) {
  return Container(
    height: height * .25,
    width: width,
    decoration: BoxDecoration(
        color: isSelected
            ? AppColors.tallyColor.withOpacity(.1)
            : AppColors.lightGrey.withOpacity(.2),
        border: Border.all(
            color: isSelected
                ? AppColors.tallyColor
                : AppColors.lightGrey.withOpacity(.2)),
        borderRadius: const BorderRadius.all(Radius.circular(10))),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          width: width * .8,
          fit: BoxFit.fill,
        ),
        const SizedBox(
          height: 10,
        ), // Images of the cars
        Text(title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.lightBackgroundColor)),
        const SizedBox(
          height: 5,
        ), // Images of the cars

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 34),
          child: Row(
            children: [
              const Icon(
                Icons.person,
                color: AppColors.lightBackgroundColor,
                size: 12,
              ),
              Text(
                ' $rating',
                style: const TextStyle(
                    color: AppColors.lightBackgroundColor, fontSize: 12),
              ),
              const Expanded(child: SizedBox()),
              const Icon(
                Icons.access_time,
                color: AppColors.lightBackgroundColor,
                size: 12,
              ),
              Text(
                ' $eta',
                style: const TextStyle(
                    color: AppColors.lightBackgroundColor, fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ), // Images of the cars

        Text(
          price,
          style: const TextStyle(color: AppColors.tallyColor),
        ),
      ],
    ),
  );
}
