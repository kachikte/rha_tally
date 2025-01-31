import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rha/src/config/config.dart';
import 'package:rha/src/domain/domain.dart';
import 'package:rha/src/presentation/presentation.dart';
import 'package:dio/dio.dart' as dio;
import 'package:rha/src/utils/utils.dart';

class TripHistoryScreen extends StatefulWidget {
  @override
  _TripHistoryScreenState createState() => _TripHistoryScreenState();
}

class _TripHistoryScreenState extends State<TripHistoryScreen> {
  TripController tripController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    tripController.getTrips();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.darkBackgroundColor,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: AppColors.tallyColor,
        elevation: 0,
      ),
      backgroundColor: AppColors.lightBackgroundColor,
      body: Obx(() => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                width: size.width,
                decoration: const BoxDecoration(color: AppColors.tallyColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Rides',
                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      tripController.isUpcoming.value =
                          !tripController.isUpcoming.value;
                    },
                    child: Text(
                      'Upcoming',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: tripController.isUpcoming.value
                              ? AppColors.tallyColor
                              : AppColors.darkBackgroundColor),
                    ),
                  ),
                  const SizedBox(width: 150),
                  GestureDetector(
                    onTap: () {
                      tripController.isUpcoming.value =
                          !tripController.isUpcoming.value;
                    },
                    child: Text(
                      'History',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: !tripController.isUpcoming.value
                              ? AppColors.tallyColor
                              : AppColors.darkBackgroundColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: tripController.isUpcoming.value
                        ? Divider(
                            indent: 30,
                            endIndent: 30,
                            thickness: 4,
                            height: 4,
                            color: tripController.isUpcoming.value
                                ? AppColors.tallyColor
                                : AppColors.darkBackgroundColor,
                          )
                        : const SizedBox(),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: !tripController.isUpcoming.value
                        ? Divider(
                            indent: 30,
                            endIndent: 30,
                            thickness: 4,
                            height: 4,
                            color: !tripController.isUpcoming.value
                                ? AppColors.tallyColor
                                : AppColors.darkBackgroundColor,
                          )
                        : const SizedBox(),
                  ),
                ],
              ),
              Divider(
                height: 3,
                color: AppColors.darkBackgroundColor.withOpacity(.1),
                thickness: 5,
              ),
              FutureBuilder(future: tripController.getTrips(), builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    height: size.height * .4,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.tallyColor,
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return SizedBox(
                    height: size.height * .4,
                    child: const Center(
                      child: Text('Error loading trips'),
                    ),
                  );
                } else {
                  log('THis is the snapshot trips - ${(snapshot.data as dio.Response).data['data']}');
                  List<TripModel> tripModelsAccepted= [];
                  List<TripModel> tripModelsCompleted= [];

                  for (var tripMode in (snapshot.data as dio.Response).data['data']) {
                    TripModel tripModel = TripModel.fromJson(json: tripMode);
                    if (tripModel.status != 'completed' && tripModel.status != 'rejected') {
                      tripModelsAccepted.add(tripModel);
                    }
                    if (tripModel.status == 'completed' || tripModel.status == 'rejected') {
                      tripModelsCompleted.add(tripModel);
                    }
                  }

                  // log('Finalized trip list - ${tripModels[0].driverId}');
                  return Expanded(
                    child: tripController.isUpcoming.value
                        ? (tripModelsAccepted.isEmpty ? SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: size.height * .15),
                          Center(
                            child: Image.asset(AppImages.tallySchedulePng),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: Text(
                              'Schedule your first ride',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.w300),
                            ),
                          ),
                        ],
                      ),
                    ) : ListView.separated(
                      itemCount: tripModelsAccepted.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () =>
                              Get.toNamed(AppRoutes.upcomingTrip, arguments: {
                                'tripModel': tripModelsAccepted[index]
                              }),
                          child: TripHistoryRow(
                            height: size.height,
                            width: size.width,
                            tripModel: tripModelsAccepted[index]),
                        );
                      },
                      separatorBuilder: (context, index) {
                        // return const Divider(
                        //   indent: 15,
                        //   endIndent: 15,
                        // );
                        return const SizedBox(
                          height: 5,
                        );
                      },
                    ))
                        : (tripModelsCompleted.isEmpty ? SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: size.height * .15),
                          Center(
                            child: Image.asset(AppImages.tallySchedulePng),
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: Text(
                              'Schedule your first ride',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: FontWeight.w300),
                            ),
                          ),
                        ],
                      ),
                    ) : ListView.separated(
                      itemCount: tripModelsCompleted.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () =>
                              Get.toNamed(AppRoutes.tripHistoryDetail, arguments:  {
                                'trip': tripModelsCompleted[index]
                              }),
                          child: TripHistoryRow(
                            height: size.height,
                            width: size.width,
                            tripModel: tripModelsCompleted[index],
                            // isTally: true,
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        // return const Divider(
                        //   indent: 15,
                        //   endIndent: 15,
                        // );
                        return const SizedBox(
                          height: 5,
                        );
                      },
                    ))
                  );
                }
              }),
              // Expanded(
              //   child: tripController.isUpcoming.value
              //       ? SingleChildScrollView(
              //           child: Column(
              //             children: [
              //               SizedBox(height: size.height * .15),
              //               Center(
              //                 child: Image.asset(AppImages.tallySchedulePng),
              //               ),
              //               const SizedBox(height: 20),
              //               Center(
              //                 child: Text(
              //                   'Schedule your first ride',
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .bodyMedium!
              //                       .copyWith(fontWeight: FontWeight.w300),
              //                 ),
              //               ),
              //             ],
              //           ),
              //         )
              //       : ListView.separated(
              //           itemCount: 4,
              //           itemBuilder: (context, index) {
              //             return GestureDetector(
              //               onTap: () =>
              //                   Get.toNamed(AppRoutes.tripHistoryDetail),
              //               child: TripHistoryRow(
              //                   height: size.height,
              //                   width: size.width,
              //                   isTally: index.isEven),
              //             );
              //           },
              //           separatorBuilder: (context, index) {
              //             return const Divider(
              //               indent: 15,
              //               endIndent: 15,
              //             );
              //           },
              //         ),
              // ),
            ],
          )),
    );
  }
}
