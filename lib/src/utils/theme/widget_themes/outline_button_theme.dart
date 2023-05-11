import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

class TOutlinedButtonTheme {
  TOutlinedButtonTheme._();

  static final LightOutlinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(),
          foregroundColor: tSecondaryClr,
          side: BorderSide(color: tSecondaryClr),
          padding: EdgeInsets.symmetric(vertical: tButtonHeight)));

  static final DarkOutlinedButtonTheme = OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(),
          foregroundColor: tWhiteClr,
          side: BorderSide(color: tWhiteClr),
          padding: EdgeInsets.symmetric(vertical: tButtonHeight)));
}
