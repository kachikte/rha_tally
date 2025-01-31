import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rha/src/config/config.dart';
import 'package:rha/src/presentation/presentation.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  OnboardingController onboardingController = Get.put(OnboardingController());

  Size screenSize = AppConfig.getSize;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> bottomNav = [
      {
        'widget': Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () => onboardingController.onNextPage(),
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(
                      Size(screenSize.width * 0.92, screenSize.height * 0.07)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColors.tallyColor),
                  foregroundColor: MaterialStateProperty.all<Color>(
                      AppColors.lightBackgroundColor),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(screenSize.width * 0.02)))),
              child: const Text(
                "Next",
                style: TextStyle(
                    color: AppColors.darkBackgroundColor, fontSize: 12),
              ),
            )
          ],
        )
      },
      {
        'widget': Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () => onboardingController.onNextPage(),
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(
                      Size(screenSize.width * 0.95, screenSize.height * 0.07)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColors.tallyColor),
                  foregroundColor: MaterialStateProperty.all<Color>(
                      AppColors.lightBackgroundColor),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(screenSize.width * 0.02)))),
              child: const Text(
                "Next",
                style: TextStyle(
                    color: AppColors.darkBackgroundColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        )
      },
      {
        'widget': Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.signup);
              },
              style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all<Size>(
                      Size(screenSize.width * 0.95, screenSize.height * 0.07)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(AppColors.tallyColor),
                  foregroundColor: MaterialStateProperty.all<Color>(
                      AppColors.lightBackgroundColor),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(screenSize.width * 0.02)))),
              child: const Text(
                "Sign Up as a Passenger",
                style: TextStyle(
                    color: AppColors.darkBackgroundColor, fontSize: 12),
              ),
            ),
            // OutlinedButton(
            //   onPressed: () {},
            //   style: ButtonStyle(
            //       fixedSize: MaterialStateProperty.all<Size>(
            //           Size(screenSize.width * 0.95, screenSize.height * 0.07)),
            //       side: MaterialStateProperty.all<BorderSide>(
            //         const BorderSide(
            //           color: AppColors.tallyColor, // Set border color here
            //           width: 1.0, // Set border width here
            //         ),
            //       ),
            //       backgroundColor: MaterialStateProperty.all<Color>(
            //           AppColors.lightBackgroundColor),
            //       foregroundColor: MaterialStateProperty.all<Color>(
            //           AppColors.lightBackgroundColor),
            //       shape: MaterialStateProperty.all<OutlinedBorder>(
            //           RoundedRectangleBorder(
            //               borderRadius:
            //                   BorderRadius.circular(screenSize.width * 0.02)))),
            //   child: const Text(
            //     "Sign Up as a Driver",
            //     style: TextStyle(
            //         color: AppColors.darkBackgroundColor, fontSize: 12),
            //   ),
            // ),
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.login),
              child: RichText(
                text: const TextSpan(
                    style: TextStyle(
                        fontSize: 12,
                        wordSpacing: 3,
                        color: AppColors.darkBackgroundColor),
                    children: [
                      TextSpan(text: "Already have an account? "),
                      TextSpan(
                          text: "Log In",
                          style: TextStyle(
                              color: AppColors.tallyColor,
                              fontWeight: FontWeight.w400)),
                    ]),
              ),
            ),
          ],
        )
      }
    ];

    return Scaffold(
      body: Stack(children: [
        PageView.builder(
            controller: onboardingController.pageController,
            itemCount: onboardingController.pages.length,
            onPageChanged: (int page) {
              setState(() {
                onboardingController.activePage = page;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return IntroWidget(
                color: onboardingController.pages[index]['color'],
                title: onboardingController.pages[index]['title'],
                description: onboardingController.pages[index]['description'],
                image: onboardingController.pages[index]['image'],
                skip: onboardingController.pages[index]['skip'],
                onTab: onboardingController.onNextPage,
                index: index,
                widget: bottomNav[index]['widget'],
              );
            }),
        Positioned(
          top: AppConfig.getSize.height * .71,
          right: 0,
          left: 0,
          child: Column(
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildIndicator())
            ],
          ),
        )
      ]),
    );
  }

  List<Widget> _buildIndicator() {
    final indicators = <Widget>[];

    for (var i = 0; i < onboardingController.pages.length; i++) {
      if (onboardingController.activePage == i) {
        indicators.add(_indicatorsTrue());
      } else {
        indicators.add(_indicatorsFalse());
      }
    }
    return indicators;
  }

  Widget _indicatorsTrue() {
    final String color;
    if (onboardingController.activePage == 0) {
      color = '#FAC100';
    } else if (onboardingController.activePage == 1) {
      color = '#FAC100';
    } else {
      color = '#FAC100';
    }

    return AnimatedContainer(
      duration: const Duration(microseconds: 300),
      height: 6,
      width: 42,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: hexToColor(color),
      ),
    );
  }

  Widget _indicatorsFalse() {
    return AnimatedContainer(
      duration: const Duration(microseconds: 300),
      height: 8,
      width: 8,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: AppColors.lightGrey,
      ),
    );
  }
}

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex));

  return Color(int.parse(hex.substring(1), radix: 16) +
      (hex.length == 7 ? 0xFF000000 : 0x00000000));
}
