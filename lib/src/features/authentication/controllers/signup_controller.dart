import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_setup/src/features/authentication/models/user_model.dart';

import '../../../repository/User_repository/user_repository.dart';
import '../../../repository/authentication_repository/authentication_repository.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();
  final userRepo = Get.put(UserRepository());

  // get phoneAuthentication => null;

//Call this Function from Design & it will do the rest
  void registerUser(String? email, String? password) {
    String? error = AuthenticationRepository.instance
        .createUserWithEmailAndPAssword(email!, password!) as String?;
    if (error != null) {
      Get.showSnackbar(GetSnackBar(
        message: error.toString(),
      ));
    }
  }

  void LoginUser(String email, String password) {
    AuthenticationRepository.instance
        .LoginWithEmailAndPAssword(email, password);
  }

  Future<void> createUser(UserModel user) async {
    phoneAuthentication(user.phoneNo!);
    await userRepo.createUser(user);

    registerUser(user.email!, user.password!);
  }

  void phoneAuthentication(String? phoneNo) {
    AuthenticationRepository.instance.phoneAuthentication(phoneNo!);
  }
}
