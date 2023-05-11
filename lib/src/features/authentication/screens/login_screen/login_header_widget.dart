import 'package:flutter/material.dart';

import '../../../../constants/image_strings.dart';
import '../../../../constants/text_strings.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: AssetImage(tSplashImage),
          height: size.height * 0.2,
        ),
        Text(
          tLoginTitle,
          style: Theme.of(context).textTheme.headline3,
        ),
        Text(
          tLoginSubtitle,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
