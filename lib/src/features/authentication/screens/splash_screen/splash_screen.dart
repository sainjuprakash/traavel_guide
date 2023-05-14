import 'package:flutter/material.dart';

import '../../../../constants/image_strings.dart';
import '../../../../constants/sizes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 80,
            left: tDefaultSize,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "hello",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(
                  "Learn To Code.\nFree for Everyone",
                  style: Theme.of(context).textTheme.displayMedium,
                )
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            child: Image(image: AssetImage(tSplashImage)),
          )
        ],
      ),
    );
  }
}
