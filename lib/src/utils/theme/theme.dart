import 'package:flutter/material.dart';
import 'package:login_setup/src/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:login_setup/src/utils/theme/widget_themes/outline_button_theme.dart';
import 'package:login_setup/src/utils/theme/widget_themes/text_field_theme.dart';
import 'package:login_setup/src/utils/theme/widget_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._();
  static ThemeData LightTheme = ThemeData(
      elevatedButtonTheme: TElevatedButtonTheme.LightElevatedButtonTheme,
      brightness: Brightness.light,
      textTheme: TTextTheme.LightTextTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.LightOutlinedButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.LightInputDecorationTheme);

  static ThemeData DarkTheme = ThemeData(
      elevatedButtonTheme: TElevatedButtonTheme.DarkElevatedButtonTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.DarkOutlinedButtonTheme,
      brightness: Brightness.dark,
      textTheme: TTextTheme.DarkTextTheme,
      inputDecorationTheme: TTextFormFieldTheme.DarkInputDecorationTheme);
}
