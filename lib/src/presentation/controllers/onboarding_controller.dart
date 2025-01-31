import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rha/src/config/config.dart';

class OnboardingController extends GetxController {
  void onNextPage() {
    if (activePage < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastEaseInToSlowEaseOut,
      );
    }
  }

  final List<Map<String, dynamic>> pages = [
    {
      'color': '#FAC100',
      'title': 'Hmmm, Healthy food',
      'image': AppImages.tallyOnboardingScreenOne,
      'description': "Get ready to ride smarter \n with Tally",
      'skip': true,
    },
    {
      'color': '#FAC100',
      'title': 'Fresh Drinks, Stay Fresh',
      'image': AppImages.tallyOnboardingScreenTwo,
      'description': 'Schedule your trips with \n ease on our app',
      'skip': true,
    },
    {
      'color': '#FAC100',
      'title': 'Let\'s Cooking',
      'image': AppImages.tallyOnboardingScreenThree,
      'description': 'Plan ahead with ease, ride \n on time ',
      'skip': false,
    },
  ];

  final PageController pageController = PageController();

  int activePage = 0;
}
