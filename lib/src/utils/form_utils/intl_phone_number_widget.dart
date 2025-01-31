import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:rha/src/config/config.dart';

class IntlPhoneNumberWidget extends StatelessWidget {
  final PhoneNumber number;
  final TextEditingController textEditingController;

  const IntlPhoneNumberWidget(
      {super.key, required this.number, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return InternationalPhoneNumberInput(
      textStyle: const TextStyle(color: AppColors.lightBackgroundColor),
      inputDecoration: InputDecoration(
          border: AppDecorations.borderOutline,
          enabledBorder: AppDecorations.borderOutline,
          disabledBorder: AppDecorations.borderOutline,
          hintText: "Phone Number",
          hintStyle: const TextStyle(color: AppColors.lightBackgroundColor),
          focusedBorder: AppDecorations.borderOutline),
      onInputChanged: (PhoneNumber number) {
        print(number.phoneNumber);
      },
      isEnabled: true,
      selectorConfig: const SelectorConfig(
        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
      ),
      ignoreBlank: false,
      autoValidateMode: AutovalidateMode.disabled,
      selectorTextStyle: const TextStyle(color: AppColors.lightBackgroundColor),
      initialValue: number,
      textFieldController: textEditingController,
      formatInput: false,
      onSaved: (PhoneNumber number) {
        print('On Saved: $number');
      },
    );
  }
}
