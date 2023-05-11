import 'package:flutter/material.dart';
import 'package:login_setup/src/common_widgets/forms/form_header-widgets.dart';
import 'package:login_setup/src/constants/image_strings.dart';
import 'package:login_setup/src/constants/sizes.dart';
import 'package:login_setup/src/constants/text_strings.dart';
import 'package:login_setup/src/features/authentication/screens/forgot_password/forget_password_otp/otp_screen.dart';

class ForgetPasswordMailScreen extends StatelessWidget {
  const ForgetPasswordMailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(tDefaultSize),
          child: Column(children: [
            SizedBox(
              height: tDefaultSize * 4,
            ),
            FormHeaderWidget(
              image: tForgotPasswordImage,
              title: tForgetPassword,
              subTitle: tForgetPasswordSubtitle,
              crossAxisAlignment: CrossAxisAlignment.center,
              heightBetween: 30.0,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: tFormHeight,
            ),
            Form(
              child: Column(children: [
                TextFormField(
                  decoration: InputDecoration(
                      label: Text(tEmail),
                      hintText: tEmail,
                      prefixIcon: Icon(Icons.mail_outline_rounded)),
                ),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OtpScreen()));
                      },
                      child: Text("Next")),
                )
              ]),
            )
          ]),
        ),
      )),
    );
  }
}
