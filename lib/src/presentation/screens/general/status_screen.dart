import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rha/src/config/config.dart';
import 'package:rha/src/presentation/presentation.dart';

class StatusScreen extends StatefulWidget {
  final Map<String, dynamic> val;

  const StatusScreen({required this.val});

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool remv = widget.val['remv'] ?? false;
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColors.lightBackgroundColor,
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: height * .3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.val['icon'],
                SizedBox(
                  height: height * .05,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    widget.val['text'],
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: height * .01,
                ),
                widget.val['subText'] != null
                    ? Container(
                        width: width * .5,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          widget.val['subText'],
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontWeight: FontWeight.w300),
                        ),
                      )
                    : const SizedBox(),
                SizedBox(
                  height: height * .05,
                ),
                AppButton(
                    buttonRadius: 10,
                    pressedFunction: remv ? () => Get.offAllNamed(widget.val['function']) : () => Get.toNamed(widget.val['function']),
                    buttonColor: AppColors.tallyColor,
                    buttonText: widget.val['buttonText'] ?? 'Continue'),
                SizedBox(
                  height: height * .3,
                ),
              ],
            ),
          ),
        ));
  }
}
