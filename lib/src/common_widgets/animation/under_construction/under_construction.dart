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
            Lottie.network(
                'https://assets3.lottiefiles.com/private_files/lf30_y9czxcb9.json'),
          ],
        ),
      ),
    );
  }
}
