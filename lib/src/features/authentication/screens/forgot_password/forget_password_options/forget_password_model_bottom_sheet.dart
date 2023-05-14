import 'package:flutter/material.dart';
import 'package:login_setup/src/constants/sizes.dart';
import 'package:login_setup/src/constants/text_strings.dart';
import 'package:login_setup/src/features/authentication/screens/forgot_password/forget_password_options/forget_password_btn_widget.dart';

import '../forget_password_mail/forget_password_mail_screen.dart';

class ForgetPasswordScreen {
  static Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        builder: (context) => Container(
              padding: EdgeInsets.all(tDefaultSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tForgetPasswordTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  Text(
                    tForgetPasswordSubtitle,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ForgetPasswordBtnidget(
                    btnIcon: Icons.mail_outline_rounded,
                    title: tEmail,
                    subTitle: tResetViaEmail,
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ForgetPasswordMailScreen()));
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ForgetPasswordBtnidget(
                    btnIcon: Icons.mobile_friendly_rounded,
                    title: tPhoneNo,
                    subTitle: tResetViaPhone,
                    onTap: () {},
                  ),
                ],
              ),
            ));
  }
}
