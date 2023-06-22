import 'package:get/get.dart';
import 'package:login_setup/src/features/authentication/models/user_model.dart';
import 'package:login_setup/src/repository/authentication_repository/authentication_repository.dart';

import '../../../repository/User_repository/user_repository.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  // Get User Email and pass it to UserRepository to fetch user record
  getUserData() {
    //final user = _authRepo.firebaseUser.value?.email;
    final email = _authRepo.firebaseUser!.email;
    if (email != null) {
      return _userRepo.getUserDetails(email);
    } else {
      throw Exception("User email is null");
      // Alternatively, you can return a default UserModel instance
      // return UserModel();
    }
  }

  Future<List<UserModel>> getAllUser() async {
    try {
      return await _userRepo.allUser();
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch all users");
      return [];
    }
  }

  Future<void> updateRecord(UserModel user) async {
    try {
      await _userRepo.updateUserRecord(user);
    } catch (e) {
      Get.snackbar("Error", "Failed to update user record");
    }
  }
}