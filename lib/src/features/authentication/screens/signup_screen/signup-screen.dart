import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_setup/src/common_widgets/forms/form_header-widgets.dart';
import 'package:login_setup/src/constants/colors.dart';
import 'package:login_setup/src/constants/image_strings.dart';
import 'package:login_setup/src/constants/sizes.dart';
import 'package:login_setup/src/constants/text_strings.dart';
import 'package:login_setup/src/features/authentication/screens/google_sign_in/google_sign_in.dart';
import 'package:login_setup/src/features/authentication/screens/login_screen/login_screen.dart';
import 'package:login_setup/src/features/authentication/screens/signup_screen/signup_form_widget.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(tDefaultSize),
              child: Column(
                children: [
                  FormHeaderWidget(
                      image: tSplashImage,
                      title: tSingUpTitle,
                      subTitle: tSignUpSubtitle),
                  SignUpFormWidget(),
                  Column(
                    children: [
                      Text('OR'),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () => Get.to(GoogleSignInScreen()),
                          icon: Image(
                            image: AssetImage('assets/images/google.png'),
                            width: 20.0,
                          ),
                          label: Text(tSignInWithGoogle.toUpperCase()),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text.rich(TextSpan(children: [
                            TextSpan(
                                text: tAlreadyHaveAnAccount,
                                style: Theme.of(context).textTheme.bodyText1),
                            TextSpan(text: tLogin.toUpperCase())
                          ])))
                    ],
                  )
                ],
              )),
        ),
      ),
    );
  }
}
