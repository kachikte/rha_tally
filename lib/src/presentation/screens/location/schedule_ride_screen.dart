import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rha/src/config/app_colors.dart';
import 'package:rha/src/config/app_routes.dart';
import 'package:rha/src/domain/domain.dart';
import 'package:rha/src/presentation/controllers/controllers.dart';
import 'package:rha/src/utils/utils.dart';

class ScheduleRideScreen extends StatefulWidget {
  @override
  _ScheduleRideScreenState createState() => _ScheduleRideScreenState();
}

class _ScheduleRideScreenState extends State<ScheduleRideScreen> {
  ProfileController profileController = Get.find();
  TripController tripController = Get.find();

  late GoogleMapController _mapController;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  LatLng _initialPosition = LatLng(37.7749, -122.4194); // Default coordinates

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  // Opens date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        // tripController.scheduledDate.value = picked;
        tripController.scheduledDate.value = getFormattedDate();
      });
    }
  }

  // Opens time picker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        // tripController.scheduledTime.value = picked;
        tripController.scheduledTime.value = getFormattedTime();
      });
    }
  }

  String getFormattedDate() {
    return "${_selectedDate.day} ${_getMonthName(_selectedDate.month)} ${_selectedDate.year}";
  }

  String getFormattedTime() {
    final hour = _selectedTime.hourOfPeriod.toString().padLeft(2, '0');
    final minute = _selectedTime.minute.toString().padLeft(2, '0');
    final period = _selectedTime.period == DayPeriod.am ? 'AM' : 'PM';
    return "$hour:$minute $period";
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
                color: Colors.black,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              padding: const EdgeInsets.all(16.0),
              height: 320,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Schedule a Ride',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    getFormattedDate(),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.yellow[700],
                    ),
                  ),
                  Text(
                    getFormattedTime(),
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.yellow[700],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Date Picker Button
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () => _selectDate(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[900],
                            // Background color
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.calendar_today, color: Colors.white),
                              SizedBox(width: 10),
                              Text(
                                'Choose Date',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Time Picker Button
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () => _selectTime(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[900],
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.access_time, color: Colors.white),
                              SizedBox(width: 10),
                              Text(
                                'Choose Time',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Cancel and Continue buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 50,
                        width: width * .45,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Cancel'),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: width * .45,
                        child: ElevatedButton(
                          onPressed: () async {
                            // GetDriversDto getDriversDto = GetDriversDto(
                            //     destinationLat: 29.7604,
                            //     destinationLng: -95.3698,
                            //     scheduledDate: tripController.scheduledDate.value,
                            //     scheduledTime: tripController.scheduledTime.value,
                            //     tripType: Constants.now,
                            //     destinationAddress: "test destination",
                            //     originAddress: "test origin",
                            //     originLat: profileController.userLat.value,
                            //     originLng: profileController.userLng.value);
                            // ResponseModel responseModel = await tripController
                            //     .getDrivers(getDriversDto: getDriversDto);
                            ResponseModel responseModel = await ResponseModel.empty();
                            if (responseModel.isError) {
                              Get.snackbar(
                                  'Error', 'Cannot get drivers at this time',
                                  backgroundColor: AppColors.appRed,
                                  colorText: AppColors.lightBackgroundColor);
                              // UtilFunctions.showTopSnackError(
                              //     context, 'Cannot get drivers at this time');
                              return;
                            } else {
                              Get.toNamed(AppRoutes.selectRide,
                                  arguments: {'ride': responseModel.data});
                            }
                          },
                          // Get.toNamed(AppRoutes.rideDestination),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow[700],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () {
                  // Menu button action
                },
              ),
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
        ],
      ),
    );
  }
}
