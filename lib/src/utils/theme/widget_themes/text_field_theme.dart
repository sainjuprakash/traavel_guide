import 'package:flutter/material.dart';
import 'package:login_setup/src/constants/colors.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecorationTheme LightInputDecorationTheme = InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
      prefixIconColor: tSecondaryClr,
      floatingLabelStyle: TextStyle(color: tSecondaryClr),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(width: 2.0, color: tSecondaryClr)));

  static InputDecorationTheme DarkInputDecorationTheme = InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
      prefixIconColor: tPrimaryClr,
      floatingLabelStyle: TextStyle(color: tPrimaryClr),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(width: 2.0, color: tPrimaryClr)));
}
