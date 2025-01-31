import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:geolocator/geolocator.dart';

import 'package:rha/src/config/app_colors.dart';
import 'package:rha/src/config/app_routes.dart';
import 'package:rha/src/presentation/presentation.dart';
import 'package:rha/src/utils/utils.dart'; // For current location

class RideDestinationScreen extends StatefulWidget {
  @override
  _RideDestinationScreenState createState() => _RideDestinationScreenState();
}

class _RideDestinationScreenState extends State<RideDestinationScreen> {
  TripController tripController = Get.find();
  final TextEditingController _startLocationController =
      TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final String _googleApiKey =
      "AIzaSyDuy-QbvOEMAAz_CzqzlX5AXRCZP1d1WRY"; // Replace with your API Key

  @override
  void initState() {
    super.initState();
    _fetchCurrentLocation(); // Fetch the current location on startup
  }

  /// Fetch current location and update the start location field
  Future<void> _fetchCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enable location services.")),
        );
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Location permissions are denied.")),
          );
          return;
        }
      }

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Use reverse geocoding to get the address
      GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: _googleApiKey);
      PlacesSearchResponse response = await places.searchNearbyWithRadius(
        Location(lat: position.latitude, lng: position.longitude),
        50, // radius in meters
      );

      String currentAddress = response.results.isNotEmpty
          ? response.results.first.name
          : Constants.myCurrentLocation;

      setState(() {
        _startLocationController.text = currentAddress;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching location: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.lightBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: AppColors.darkBackgroundColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: AppColors.lightBackgroundColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Where are you going to?',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkBackgroundColor,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Pre-schedule your rides with ease',
                  style: TextStyle(
                      fontSize: 16,
                      color: AppColors.darkBackgroundColor,
                      fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 130,
                      height: 50,
                      child: Obx(() => AppButton(
                        pressedFunction: () {
                          tripController.showBottomDest.value = !tripController.showBottomDest.value;
                        },
                        buttonIcon: Icon(
                          tripController.rideSchedule.value == Constants.now ? Icons.access_time_filled_rounded : Icons.calendar_month_rounded,
                          color: AppColors.darkBackgroundColor,
                        ),
                        buttonColor: AppColors.darkBackgroundColor.withOpacity(.2),
                        buttonText: tripController.rideSchedule.value.split(' ')[2],
                        buttonRadius: 10,
                      )),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Start location input
                Row(
                  children: [
                    const Icon(Icons.circle_outlined,
                        color: AppColors.tallyColor, size: 24),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          Prediction? prediction = await PlacesAutocomplete.show(
                            context: context,
                            apiKey: _googleApiKey,
                            mode: Mode.overlay,
                            // Use overlay or fullscreen
                            language: "en",
                            types: ["geocode", "establishment", "restaurant"],
                            strictbounds: false,
                            components: [
                              Component(Component.country, "ng")
                            ], // Restrict to Nigeria
                          );

                          if (prediction != null) {
                            _handleStartLocationSelection(prediction);
                          }
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            style: const TextStyle(
                                fontSize: 15, color: AppColors.darkBackgroundColor),
                            controller: _startLocationController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'Enter your starting point',
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.yellow[700],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Destination input
                Row(
                  children: [
                    const Icon(Icons.location_on_rounded,
                        color: AppColors.tallyColor, size: 24),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          Prediction? prediction = await PlacesAutocomplete.show(
                            context: context,
                            apiKey: _googleApiKey,
                            mode: Mode.overlay,
                            language: "en",
                            types: ["geocode", "establishment", "restaurant"],
                            strictbounds: false,
                            components: [Component(Component.country, "ng")],
                          );

                          if (prediction != null) {
                            _handleDestinationSelection(prediction);
                          }
                        },
                        child: AbsorbPointer(
                          child: TextField(
                            style: const TextStyle(
                                fontSize: 15, color: AppColors.darkBackgroundColor),
                            controller: _destinationController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'Enter your destination',
                              suffixIcon: Icon(
                                Icons.search,
                                color: Colors.yellow[700],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Obx(() => Visibility(
            visible: tripController.showBottomDest.value,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height * .32,
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                    color: AppColors.darkBackgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: [
                    SizedBox(
                      width: width * .8,
                      height: height * .07,
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Location icon with circular background
                          SizedBox(height: 30),
                          Center(
                            child: Text(
                              'Select type of Trip',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 17,
                                color: AppColors.lightBackgroundColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    AppButton(
                        buttonHeight: 50,
                        buttonRadius: 10,
                        pressedFunction: () {
                          tripController.rideSchedule.value = Constants.now;
                          tripController.showBottomDest.value  = !tripController.showBottomDest.value;
                        },
                        buttonColor: AppColors.lightBackgroundColor.withOpacity(.2),
                        textColor: AppColors.lightBackgroundColor,
                        buttonIcon: const Icon(Icons.access_time_filled_rounded, color: AppColors.lightBackgroundColor,),
                        buttonText: 'Pick up Now'),
                    const SizedBox(height: 10),

                    AppButton(
                        buttonHeight: 50,
                        buttonRadius: 10,
                        pressedFunction: () {
                          tripController.rideSchedule.value = Constants.later;
                          tripController.showBottomDest.value  = !tripController.showBottomDest.value;
                        },
                        buttonColor: AppColors.lightBackgroundColor.withOpacity(.2),
                        textColor: AppColors.lightBackgroundColor,
                        buttonIcon: const Icon(Icons.calendar_month_rounded, color: AppColors.lightBackgroundColor,),
                        buttonText: 'Schedule for Later'),
                    const SizedBox(height: 10),

                    // Enable Location button
                    AppButton(
                        buttonHeight: 50,
                        buttonRadius: 10,
                        pressedFunction: () =>
                            Get.toNamed(AppRoutes.locationMap),
                        buttonColor: AppColors.tallyColor,
                        buttonText: 'Next'),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),))

        ],
      ),
    );
  }

  /// Handles the selected start location and updates the controller
  Future<void> _handleStartLocationSelection(Prediction prediction) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: _googleApiKey);
    PlacesDetailsResponse detail =
        await places.getDetailsByPlaceId(prediction.placeId!);

    // LatLng lng = LatLng(detail.result.geometry!.location.lat, detail.result.geometry!.location.lng);

    final String selectedAddress = detail.result.formattedAddress ?? "";
    setState(() {
      _startLocationController.text = selectedAddress;
      tripController.startDestination.value = selectedAddress;
    });
  }

  /// Handles the selected destination and updates the controller
  Future<void> _handleDestinationSelection(Prediction prediction) async {
    GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: _googleApiKey);
    PlacesDetailsResponse detail =
        await places.getDetailsByPlaceId(prediction.placeId!);

    // LatLng lng = LatLng(detail.result.geometry!.location.lat, detail.result.geometry!.location.lng);

    final String selectedAddress = detail.result.formattedAddress ?? "";
    setState(() {
      _destinationController.text = selectedAddress;
      tripController.endDestination.value = selectedAddress;
    });
    Get.toNamed(AppRoutes.locationMap);
  }
}
