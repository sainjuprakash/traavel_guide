import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_setup/firebase_options.dart';
import 'package:login_setup/src/features/authentication/controllers/otp_controller.dart';
import 'package:login_setup/src/features/authentication/screens/splash_screen/splash_screen.dart';
import 'package:login_setup/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:login_setup/src/repository/authentication_repository/authentication_repository.dart';
import 'package:login_setup/src/utils/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());
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
      home: const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
