
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:login_setup/src/constants/image_strings.dart';

// import '../../features/authentication/controllers/splash_screen_controller.dart';
// class TFdeInAnimation extends StatelessWidget{
//   const TFadeInAnimation({
//     Key? key,
//     required this.splashController,
//   }); super(key:key);

// final SplashScreenController splashScreenController;

//   @override
//   Widget build(BuildContext context) {
//     return  Obx(() => AnimatedPositioned(
//       child: AnimatedOpacity(opacity: splashScreenController.animate.value?1:0, duration: Duration(milliseconds: 1600),
//       child: Image(image: AssetImage(tForgotPasswordImage)),),
//        duration: Duration(milliseconds: 1600),
//       top: splashScreenController.animate.value?0:-30,
//       left: splashScreenController.animate.value?0:-30,));
//   }



// }