import 'dart:io';
import 'dart:math';

import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:open_store/open_store.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../config/app_colors.dart';

class UtilFunctions {
  static showOverLay(BuildContext context) {
    context.loaderOverlay.show(
        widget: Container(
      color: AppColors.darkBackgroundColor.withOpacity(.2),
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.tallyColor,
        ),
      ),
    ));
  }

  static hideOverLay(BuildContext context) {
    if (context.mounted) {
      context.loaderOverlay.hide();
    }
  }

  static getSnack(
      {required String title,
      required String message,
      required Color colorText,
      required Color backgroundColor}) {
    return Get.snackbar(title, message,
        colorText: colorText, backgroundColor: backgroundColor);
  }

  static copyToClipBoard({required String data}) async {
    await Clipboard.setData(ClipboardData(text: data));
  }

  static Future<PackageInfo> getAppInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    return packageInfo;
  }

  static dateFormatFromFirebase({required dynamic date}) {
    var dateFormat =
        DateFormat(DateFormat.YEAR_MONTH_DAY).format(date).toString();
    return dateFormat;
  }

  static timeFormatFromFirebase({required dynamic date}) {
    var timeFormat = DateFormat("hh:mm a").format(date).toString();
    return timeFormat;
  }

  static showInlineSnack(BuildContext context, String message) {
    return Positioned(
        top: 700,
        child: CustomSnackBar.info(
            backgroundColor: Colors.yellow,
            textStyle: const TextStyle(color: Colors.white),
            message: message));
  }

  static showTopSnackError(BuildContext context, String message) {
    showTopSnackBar(Overlay.of(context),
        SizedBox(height: 50, child: CustomSnackBar.error(message: message)));
  }

  static showTopSnackInfo(BuildContext context, String message) {
    showTopSnackBar(
        Overlay.of(context),
        SizedBox(
            height: 50,
            child: CustomSnackBar.success(
              message: message,
              backgroundColor: AppColors.lightGrey,
              textStyle: const TextStyle(color: Colors.white),
            )));
  }

  static showTopSnackSuccess(BuildContext context, String message) {
    showTopSnackBar(Overlay.of(context),
        SizedBox(height: 50, child: CustomSnackBar.success(message: message)));
  }

  static Future launchApp({required String appId}) async {
    if (Platform.isIOS) {
      print("THIS IS IOS");
      return await OpenStore.instance.open(
        appStoreId: appId, // AppStore id of your app for iOS
        // appStoreIdMacOS: '284815942', // AppStore id of your app for MacOS (appStoreId used as default)
        // androidAppBundleId: 'com.google.android.googlequicksearchbox', // Android app bundle package name
        // windowsProductId: '9NZTWSQNTD0S' // Microsoft store id for Widnows apps
      );
    } else if (Platform.isAndroid) {
      print("THIS IS ANDRIOD");
      return await LaunchApp.openApp(
        androidPackageName: 'io.legend.legendpay.mobile',
        // iosUrlScheme: 'legendPay://',
        // appStoreLink: 'https://apps.apple.com/us/app/legend-pay/id1493647326',
        // openStore: true
      );
    } else {
      return;
    }
  }

  static skeletalLoader() {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: const Color.fromRGBO(192, 192, 192, 0.1),
      // highlightColor: Colors.grey.withOpacity(0.02),
      enabled: true,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 100,
              height: 180.0,
              color: Colors.white,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 8.0,
                    color: Colors.white,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                  ),
                  Container(
                    width: double.infinity,
                    height: 8.0,
                    color: Colors.white,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                  ),
                  Container(
                    width: 40.0,
                    height: 8.0,
                    color: Colors.white,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  static backButton(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: const ImageIcon(
        AssetImage("assets/images/icons/legendback.png"),
        color: Colors.white,
      ),
    );
  }

  static String formatPrice(String price) {
    List decPrice = price.split(".");
    List newPrice = decPrice[0].split("");
    print("THIS IS THE NEW PRICE === $decPrice");
    String convertedPrice = "";
    // int div = (newPrice.length)/3 as int;
    int mod = (newPrice.length) % 3;
    for (int k = 0; k < newPrice.length; k++) {
      if (newPrice.length - 1 == k) {
        break;
      }
      if (k < (mod - 1)) {
        print("==wotk 1");
        convertedPrice += newPrice.removeAt(k);
        continue;
      }
      if (k == (mod - 1)) {
        print("==wotk 2 =$k");
        String newP = mod == 1
            ? (newPrice.removeAt(k) + ",")
            : (newPrice.removeAt(k - 1) + ",");
        convertedPrice += newP;
      }
    }

    print("THIS IS THE CONVERTED PRICE 222 === $convertedPrice");

    print("THIS IS THE NEW PRICE 222 === $newPrice");

    for (int k = 0; k < newPrice.length; k++) {
      if (newPrice.length - 1 == k) {
        convertedPrice += newPrice[k];
        continue;
      }
      if (((k + 1) % 3) == 0) {
        convertedPrice += (newPrice[k] + ",");
        continue;
      } else {
        convertedPrice += newPrice[k];
        continue;
      }
    }

    return decPrice.length < 2
        ? convertedPrice
        : "$convertedPrice." + decPrice[1];
  }

  static dateTimeFormat({required dynamic date}) {
    var dateFormat =
        DateFormat('yyyy-MM-dd hh:mm').format(DateTime.parse(date)).toString();
    return dateFormat;
  }

  static dateFormat({required dynamic date}) {
    var dateFormat = DateFormat(DateFormat.YEAR_MONTH_DAY)
        .format(DateTime.parse(date))
        .toString();
    return dateFormat;
  }

  static timeFormat({required dynamic date}) {
    var timeFormat =
        DateFormat("hh:mm a").format(DateTime.parse(date)).toString();
    return timeFormat;
  }

  static String generateRandomString(int length) {
    const charset =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return List.generate(
        length, (index) => charset[random.nextInt(charset.length)]).join();
  }
}
