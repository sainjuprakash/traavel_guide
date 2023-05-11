import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static final LightElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(),
          foregroundColor: tWhiteClr,
          backgroundColor: tSecondaryClr,
          side: BorderSide(color: tSecondaryClr),
          padding: EdgeInsets.symmetric(vertical: tButtonHeight)));

  static final DarkElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(),
          foregroundColor: tSecondaryClr,
          backgroundColor: tWhiteClr,
          side: BorderSide(color: tWhiteClr),
          padding: EdgeInsets.symmetric(vertical: tButtonHeight)));
}
