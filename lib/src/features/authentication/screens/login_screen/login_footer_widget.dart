import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_setup/src/features/authentication/screens/google_sign_in/google_sign_in.dart';
import 'package:login_setup/src/features/authentication/screens/signup_screen/signup-screen.dart';

import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('OR'),
        SizedBox(
          height: tFormHeight - 20,
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
              icon: Image(
                image: AssetImage('assets/images/google.png'),
                width: 20.0,
              ),
              onPressed: () => Get.to(GoogleSignInScreen()),
              label: Text(tSignInWithGoogle)),
        ),
        SizedBox(
          height: tFormHeight - 20,
        ),
        TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignupScreen()));
          },
          child: Text.rich(TextSpan(
              text: tDontHaveAnAccount,
              style: Theme.of(context).textTheme.bodyText1,
              children: [
                TextSpan(
                    text: tSignUp.toUpperCase(),
                    style: TextStyle(color: Colors.blue))
              ])),
        ),
      ],
    );
  }
}
