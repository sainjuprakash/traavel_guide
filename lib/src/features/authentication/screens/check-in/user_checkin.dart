import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_setup/src/constants/constant.dart';
import 'package:login_setup/src/features/authentication/screens/dummy_dash/dash.dart';
import 'package:login_setup/src/features/authentication/screens/map_screen/map_screen.dart';

import '../../../../common_widgets/cards/category_card.dart';
import '../../../../common_widgets/cards/recommended_card.dart';
import '../../../../constants/colors.dart';
import '../../models/place_modal.dart';
import 'package:http/http.dart' as http;

import '../detail_screen/detail_screen.dart';

class CheckIn extends StatefulWidget {
  const CheckIn({Key? key}) : super(key: key);

  @override
  State<CheckIn> createState() => _CheckInState();
}

class _CheckInState extends State<CheckIn> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme;
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
        backgroundColor: tRouteColor,
        body: Stack(
          children: [
            SafeArea(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors
                                  .purple, // Set the background color to purple
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors
                                  .white, // Set the color of the arrow to white
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "User's check-in",
                            style: txtTheme.headlineMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ///
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: isDark ? tSecondaryClr : tWhiteClr,
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Center(
                                child: Text("Places",
                                    style: txtTheme.headlineMedium),
                              ),
                            ),
                            Container(height: 1,
                            color: Colors.grey,)
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ))
          ],
        ));
  }
}
