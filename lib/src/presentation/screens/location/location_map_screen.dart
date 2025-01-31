import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rha/src/config/config.dart';
import 'package:rha/src/domain/domain.dart';
import 'package:rha/src/presentation/presentation.dart';
import 'package:rha/src/utils/utils.dart';

class LocationMapScreen extends StatefulWidget {
  @override
  _LocationMapScreenState createState() => _LocationMapScreenState();
}

class _LocationMapScreenState extends State<LocationMapScreen> {
  ProfileController profileController = Get.find();
  TripController tripController = Get.find();
  late GoogleMapController _mapController;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  LatLng _initialPosition = LatLng(37.7749, -122.4194); // Default coordinates

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  String getFormattedDate() {
    return "${_selectedDate.day} ${_getMonthName(_selectedDate.month)} ${_selectedDate.year}";
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }


  String getFormattedTime() {
    final hour = _selectedTime.hourOfPeriod.toString().padLeft(2, '0');
    final minute = _selectedTime.minute.toString().padLeft(2, '0');
    final period = _selectedTime.period == DayPeriod.am ? 'AM' : 'PM';
    return "$hour:$minute $period";
  }

  @override
  void initState() {
    _initialPosition = LatLng(
        profileController.userLat.value, profileController.userLng.value);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _initialPosition = LatLng(
        profileController.userLat.value, profileController.userLng.value);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
              height: height * .3,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 60),
              decoration: const BoxDecoration(
                  color: AppColors.darkBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        color: AppColors.tallyColor,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: width * .7,
                        child: const Text(
                          '231 Adetokunbo Ademola Crescent, Abuja',
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 17,
                            color: AppColors.lightBackgroundColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Enable Location button
                  AppButton(
                      buttonHeight: 50,
                      buttonRadius: 10,
                      pressedFunction: () async {
                        if (tripController.rideSchedule.value ==
                            Constants.later) {
                          Get.toNamed(AppRoutes.scheduleRide);
                        } else {
                          _selectedDate = DateTime.now();
                          _selectedTime = TimeOfDay.now();
                          tripController.scheduledDate.value = getFormattedDate();
                          tripController.scheduledTime.value = getFormattedTime();
                          ResponseModel responseModel = await ResponseModel.empty();
                          if (responseModel.isError) {
                            UtilFunctions.showTopSnackError(
                                context, 'Cannot get drivers at this time');
                            return;
                          } else {
                            Get.toNamed(AppRoutes.selectRide,
                                arguments: {'ride': responseModel.data});
                          }
                        }
                      },
                      buttonColor: AppColors.tallyColor,
                      buttonText: 'Continue'),
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
