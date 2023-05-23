import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:login_setup/src/constants/colors.dart';
import 'package:login_setup/src/constants/sizes.dart';

class Helper extends GetxController {
//Snackbar
  static successSnackBar({required title, message}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: tWhiteClr,
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 6),
        margin: const EdgeInsets.all(tDefaultSize - 10),
        icon: const Icon(
          LineAwesomeIcons.check_circle,
          color: tWhiteClr,
        ));
  }

  static errorSnackBar({required title, message}) {
    Get.snackbar(title, message,
        isDismissible: true,
        shouldIconPulse: true,
        colorText: tWhiteClr,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 6),
        margin: const EdgeInsets.all(tDefaultSize - 10),
        icon: const Icon(
          LineAwesomeIcons.check_circle,
          color: tWhiteClr,
        ));
  }
}
