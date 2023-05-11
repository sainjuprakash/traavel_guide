import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_setup/src/features/authentication/screens/dashboard/dashboard.dart';
import 'package:login_setup/src/repository/authentication_repository/authentication_repository.dart';

class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  void verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);
    isVerified ? Get.offAll(const Dashboard()) : Get.back();
  }
}
