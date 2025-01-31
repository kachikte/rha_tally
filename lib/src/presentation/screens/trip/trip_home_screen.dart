import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rha/src/config/config.dart';
import 'package:rha/src/presentation/presentation.dart';

class TripHomeScreen extends StatefulWidget {
  @override
  _TripHomeScreenState createState() => _TripHomeScreenState();
}

class _TripHomeScreenState extends State<TripHomeScreen> {
  late GoogleMapController _mapController;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  final LatLng _initialPosition =
      const LatLng(37.7749, -122.4194); // Default coordinates

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: const AppDrawerWidget(),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 14.0,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: const BoxDecoration(
                  color: AppColors.darkBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 30),
                  SizedBox(
                    width: width,
                    child: const Text(
                      'Where are you going to?',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.lightBackgroundColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: width,
                    child: const Text(
                      'Pre-schedule your trips with ease',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.lightBackgroundColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  AppButton(
                      buttonHeight: 50,
                      buttonRadius: 10,
                      pressedFunction: () {},
                      // pressedFunction: () => Get.toNamed(AppRoutes.tripStatus),
                      buttonColor: AppColors.tallyColor,
                      buttonText: 'Schedule Ride'),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
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
                      log('this is clicking');
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
                    },
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.yellow[700],
                      child: const Text(
                        '2',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              width: width * .9,
              height: height * .1,
              decoration: const BoxDecoration(
                  color: AppColors.darkBackgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Upcoming Ride: ', // Default text style
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Pickup in 10 mins',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: AppColors.tallyColor),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: AppColors.lightBackgroundColor,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        color: AppColors.tallyColor,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'To Vintage Hub',
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    ],
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
