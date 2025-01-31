import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rha/src/config/config.dart';
import 'package:rha/src/domain/domain.dart';
import 'package:rha/src/presentation/presentation.dart';
import 'package:dio/dio.dart' as dio;

class LocationCheckerScreen extends StatefulWidget {
  @override
  _LocationCheckerScreenState createState() => _LocationCheckerScreenState();
}

class _LocationCheckerScreenState extends State<LocationCheckerScreen> {
  TextEditingController locationController = TextEditingController();
  TripController tripController = Get.find();
  ProfileController profileController = Get.find();
  Location location = Location();
  late GoogleMapController mapController;
  LatLng _initialPosition =
  const LatLng(37.7749, -122.4194); // Default San Francisco coordinates
  bool _serviceEnabled = false;
  PermissionStatus? _permissionGranted;
  bool _isLocationEnabled = false;
  late StreamSubscription<LocationData> _locationSubscription;

  @override
  void initState() {
    super.initState();
    checkLocationService();
    sumTrips();
  }

  sumTrips() async {
    tripController.unCompletedTrips.value = 0;
    tripController.completedTrips.value = 0;

    var res = await tripController.getTrips();
    var result = (res  as dio.Response).data['data'];
    log('THis is the snapshot trips - $result');

    for (var tripMode in result) {
      TripModel tripModel = TripModel.fromJson(json: tripMode);
      if (tripModel.status != 'completed') {
        tripController.unCompletedTrips.value += 1;
      }
      if (tripModel.status == 'completed') {
        tripController.completedTrips.value += 1;
      }
    }
  }

  @override
  void dispose() {
    _locationSubscription.cancel(); // Cancel the location subscription
    super.dispose();
  }

  Future<void> checkLocationService() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      if (context.mounted) {
        showLocationModal(context); // Show dialog if service is disabled

        _serviceEnabled = await location.requestService();
      }
    }

    if (_serviceEnabled) {
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
      }

      if (_permissionGranted == PermissionStatus.granted) {
        _startListeningToLocation();
        log('Showing botttom locagtion');
        // showLocationBottomModal(context);
// Start listening for location changes
      } else {
        if (context.mounted) {
          showLocationModal(context);
// Show dialog if permission not granted
        }
      }
    } else {
      if (context.mounted) {
        showLocationModal(context); // Show dialog if service is disabled
      }
    }
  }

  // Future<void> checkLocationServices() async {
  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     showLocationModal(context); // Show dialog if service is disabled
  //
  //     _serviceEnabled = await location.requestService();
  //   }
  //
  //   if (_serviceEnabled) {
  //     // showLocationModal(context); // Show dialog if service is disabled
  //     showLocationBottomModal(context);
  //     _permissionGranted = await location.hasPermission();
  //     if (_permissionGranted == PermissionStatus.denied) {
  //       _permissionGranted = await location.requestPermission();
  //     }
  //
  //     if (_permissionGranted == PermissionStatus.granted) {
  //       getUserLocation(); // Get user's current location
  //       showLocationBottomModal(context);
  //     } else {
  //       showLocationModal(context); // Show dialog if permission not granted
  //     }
  //   } else {
  //     showLocationModal(context); // Show dialog if service is disabled
  //   }
  // }

  void _startListeningToLocation() {
    _locationSubscription = location.onLocationChanged.listen((LocationData userLocation) {
      setState(() {
        _initialPosition =
            LatLng(userLocation.latitude!, userLocation.longitude!);
        _isLocationEnabled = true;
        profileController.userLat.value = userLocation.latitude!;
        profileController.userLng.value = userLocation.longitude!;

        profileController.editLocation(context);
        // Move the camera to user's updated location
        if (mapController != null) {
          mapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: _initialPosition, zoom: 15.0),
          ));
        }
      });
    });
  }

  void showLocationModal(BuildContext context) {
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
            height: height * .5,
            width: width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(height: 16),

                // Location icon with circular background
                CircleAvatar(
                  radius: 50,
                  backgroundColor: AppColors.tallyColor.withOpacity(.2),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: AppColors.tallyColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.location_on,
                      color: AppColors.darkBackgroundColor,
                      size: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Title text
                const Text(
                  'Enable your location',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // Description text
                Text(
                  'Choose your location to start finding the requests around you',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),
                // Enable Location button
                AppButton(
                    buttonHeight: 50,
                    buttonRadius: 10,
                    pressedFunction: () async {
                      bool serviceEnabled = await location.requestService();
                      if (serviceEnabled) {
                        Navigator.pop(
                            context); // Close the modal if location is enabled
                        // checkLocationService();
                        // showLocationBottomModal(context);
                      }
                    },
                    buttonColor: AppColors.tallyColor,
                    buttonText: 'Enable Location'),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }

  // void showLocationBottomModal(BuildContext context) {
  //   final double height = MediaQuery.of(context).size.height;
  //   final double width = MediaQuery.of(context).size.width;
  //   showModalBottomSheet(
  //     backgroundColor: AppColors.darkBackgroundColor,
  //     context: context,
  //     isDismissible: false,
  //     enableDrag: false,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (BuildContext context) {
  //       return Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             // Location icon with circular background
  //             const SizedBox(height: 30),
  //             SizedBox(
  //               width: width,
  //               child: const Text(
  //                 'Where are you going to?',
  //                 textAlign: TextAlign.start,
  //                 style: TextStyle(
  //                   fontSize: 20,
  //                   color: AppColors.lightBackgroundColor,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(height: 8),
  //             // Description text
  //             SizedBox(
  //               width: width,
  //               child: const Text(
  //                 'Book or Schedule your rides with ease',
  //                 textAlign: TextAlign.start,
  //                 style: TextStyle(
  //                   fontSize: 16,
  //                   color: AppColors.lightBackgroundColor,
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(height: 30),
  //             GestureDetector(
  //                 onTap: () => Get.toNamed(AppRoutes.rideDestination),
  //                 child: AppInput(
  //                     icon: const Icon(
  //                       Icons.location_on_rounded,
  //                       color: AppColors.lightBackgroundColor,
  //                     ),
  //                     enabled: false,
  //                     textEditingController: locationController,
  //                     hintText: 'Where to?',
  //                     errorText: '',
  //                     width: width,
  //                     label: '',
  //                     height: height)),
  //             // Enable Location button
  //             // AppButton(
  //             //     buttonHeight: 50,
  //             //     buttonRadius: 10,
  //             //     pressedFunction: () => Get.toNamed(AppRoutes.rideDestination),
  //             //
  //             //     // pressedFunction: () => Get.toNamed(AppRoutes.scheduleRide),
  //             //     buttonColor: AppColors.tallyColor,
  //             //     buttonText: 'Schedule Ride'),
  //             const SizedBox(height: 20),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {

    // sumTrips();

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: const AppDrawerWidget(),
      body: Stack(
        children: [
          // Google Map background
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _initialPosition,
              zoom: 13.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
              if (_isLocationEnabled) {
                // If the location is already enabled, move the camera to the user's location
                mapController.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: _initialPosition, zoom: 15.0),
                ));
              }
            },
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
                  // Location icon with circular background
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
                  // Description text
                  SizedBox(
                    width: width,
                    child: const Text(
                      'Book or Schedule your rides with ease',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.lightBackgroundColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.rideDestination),
                      child: AppInput(
                          icon: const Icon(
                            Icons.location_on_rounded,
                            color: AppColors.lightBackgroundColor,
                          ),
                          enabled: false,
                          textEditingController: locationController,
                          hintText: 'Where to?',
                          errorText: '',
                          width: width,
                          label: '',
                          height: height)),
                  // Enable Location button
                  // AppButton(
                  //     buttonHeight: 50,
                  //     buttonRadius: 10,
                  //     pressedFunction: () => Get.toNamed(AppRoutes.rideDestination),
                  //
                  //     // pressedFunction: () => Get.toNamed(AppRoutes.scheduleRide),
                  //     buttonColor: AppColors.tallyColor,
                  //     buttonText: 'Schedule Ride'),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          const Center(
            child: Text(
              'Checking Location...',
              style: TextStyle(
                  color: AppColors.lightBackgroundColor, fontSize: 20),
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
                      Get.toNamed(AppRoutes.tripHistory);
                    },
                  ),
                  Obx(() => Positioned(
                    right: 8,
                    top: 8,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.yellow[700],
                      child: Text(
                        tripController.unCompletedTrips.value.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )),
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
