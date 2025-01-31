import 'package:flutter/material.dart';
import 'package:rha/src/config/config.dart';
import 'package:rha/src/domain/models/trip_model.dart';
import 'package:rha/src/utils/utils.dart';

class TripHistoryRow extends StatelessWidget {
  final double height;
  final double width;
  final TripModel tripModel;

  const TripHistoryRow(
      {required this.height, required this.width, required this.tripModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      height: height * .11,
      child: Row(
        children: [
          SizedBox(
              width: width * .6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tripModel.endLocation,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontSize: 15,
                        color: AppColors.darkBackgroundColor.withOpacity(.7)),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  tripModel.rideType == Constants.tallyRide
                      ? Row(
                          children: [
                            Text(
                              'Tally Ride',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 14,
                                      color: AppColors.darkBackgroundColor
                                          .withOpacity(.5)),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              child: CircleAvatar(
                                radius: 3,
                                backgroundColor: AppColors.darkBackgroundColor
                                    .withOpacity(.4),
                              ),
                            ),
                            Text(
                              '₦${(tripModel.amount / 50).round() * 50}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 14,
                                      color: AppColors.darkBackgroundColor
                                          .withOpacity(.5)),
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Text(
                              '₦${(tripModel.amount / 50).round() * 50}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                      fontSize: 14,
                                      color: AppColors.darkBackgroundColor),
                            ),
                          ],
                        )
                ],
              )),
          Column(
            children: [
              Text(
                tripModel.startDate.split('kachTal')[0],
                // tripModel.endDate.split('.')[0],
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 14,
                    color: AppColors.darkBackgroundColor.withOpacity(.5)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
