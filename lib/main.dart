import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:login_setup/firebase_options.dart';
import 'package:login_setup/src/features/authentication/controllers/otp_controller.dart';
import 'package:login_setup/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:login_setup/src/repository/authentication_repository/authentication_repository.dart';
import 'package:login_setup/src/utils/theme/theme.dart';
import 'package:lottie/lottie.dart';

void main() async {
  await Future.delayed(Duration(milliseconds:500));
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  runApp(ProviderScope(child: MyApp()));
  OTPController();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: TAppTheme.LightTheme,
      darkTheme: TAppTheme.DarkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const WelcomeScreen(),
    );
  }
}

// class Splashscreen extends StatefulWidget {
//   const Splashscreen({super.key});

//   @override
//   State<Splashscreen> createState() => _SplashscreenState();
// }

// class _SplashscreenState extends State<Splashscreen> {
//   bool _isDisposed = false;
//   void dispose() {
//     _isDisposed = true;
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration(seconds: 8)).then((value) {
//       if (!_isDisposed) {
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (context) => WelcomeScreen()),
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Center(
//       child: Container(
//         height: 200,
//         width: 200,
//         child: Lottie.asset('assets/images/map_animation.json'),
//       ),
//     ));
//   }
// }
