// import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:login_setup/src/constants/text_strings.dart';
// import 'package:login_setup/src/repository/authentication_repository/authentication_repository.dart';

// class MailVerificationController extends GetxController {
//   late Timer _timer;
//   @override
//   void onInit() {
//     super.onInit();
//     sendVerificationEmail();
//     setTimerForAutoRedirect();
//   }

//   //send or resend email verification
//   Future<void> sendVerificationEmail() async {
//     try {
//       await AuthenticationRepository.instance.sendEmailVerification();
//     } catch (e) {
//       Helper.errorSnackBar(title: tOhSnap, message: e.toString());
//     }
//   }

//   //set Timer to check if verification Completed then redirect
//   void setTimerForAutoRedirect() {
//     _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
//       FirebaseAuth.instance.currentUser?.reload();
//       final user = FirebaseAuth.instance.currentUser;
//       if (user!.emailVerified) {
//         timer.cancel();

//       }
//     });
//   }

//   //Manaully check if verification completed then redirect
//   void manuallyCheckEmailVerificationStatus() {}
// }
