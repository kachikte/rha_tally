import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rha/src/config/config.dart';
import 'package:rha/src/presentation/presentation.dart';

class TripStatusScreen extends StatefulWidget {
  @override
  _TripStatusScreenState createState() => _TripStatusScreenState();
}

class _TripStatusScreenState extends State<TripStatusScreen> {
  late GoogleMapController _mapController;
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

    return Scaffold(
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
              decoration: const BoxDecoration(
                  color: AppColors.darkBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Location icon with circular background
                  const SizedBox(height: 30),

                  SizedBox(
                    width: width,
                    child: Text(
                      'Pickup in 10 mins',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.lightBackgroundColor),
                    ),
                  ),
                  const SizedBox(height: 16),

                  ColoredDriverInfoWidget(
                      width: width,
                      height: height,
                      name: 'Adeyemi',
                      rating: 4.9,
                      carType: 'Toyota Camry',
                      carColor: 'Gold',
                      plateNumber: 'RSH01AS'),
                  const SizedBox(height: 16),

                  SizedBox(
                    width: width,
                    child: Text(
                      'Route',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: AppColors.lightBackgroundColor),
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
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: AppColors.lightBackgroundColor),
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
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: AppColors.lightBackgroundColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  // Enable Location button
                  AppButton(
                      buttonHeight: 50,
                      buttonRadius: 10,
                      pressedFunction: () => Get.toNamed(AppRoutes.tripRate),
                      buttonColor: AppColors.tallyColor,
                      buttonText: 'Cancel Trip'),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          // Top navigation buttons
          Positioned(
            top: 50,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  // Menu button action
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
