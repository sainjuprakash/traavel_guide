import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UnderConstruction extends StatelessWidget {
  const UnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListView(
          children: [
            // Load a Lottie file from a remote url
            Lottie.asset('assets/images/under_construction.json'),
          ],
        ),
      ),
    );
  }
}
