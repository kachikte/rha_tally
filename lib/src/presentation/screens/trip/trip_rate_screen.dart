import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:rha/src/config/config.dart';
import 'package:rha/src/presentation/presentation.dart';

class TripRateScreen extends StatelessWidget {
  const TripRateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    TextEditingController reviewController = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.tallyColor,
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          margin: EdgeInsets.symmetric(
              vertical: height * .18, horizontal: width * .05),
          height: height,
          width: width,
          decoration: const BoxDecoration(
              color: AppColors.lightBackgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'How was your trip?',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Text(
                'Your feedback is important to us',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w300),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                child: Image.asset(
                  AppImages.personJpg,
                  width: 60,
                  height: 60,
                  fit: BoxFit.fill,
                ),
              ),
              Text(
                'Adeyemi',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              RatingBar.builder(
                initialRating: 3,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star_rate_rounded,
                  color: Colors.amber,
                  size: 70,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              AppArea(
                  fillColor: AppColors.lightGrey.withOpacity(.2),
                  textEditingController: reviewController,
                  hintText: 'Write your text',
                  errorText: '',
                  width: width,
                  label: const SizedBox(),
                  height: height),
              AppButton(
                  buttonRadius: 10,
                  buttonHeight: 60,
                  pressedFunction: () => Get.toNamed(AppRoutes.tripHome),
                  buttonColor: AppColors.tallyColor,
                  buttonText: 'Submit')
            ],
          ),
        ),
      ),
    );
  }
}
