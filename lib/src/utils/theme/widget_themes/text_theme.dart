import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TTextTheme {
  static TextTheme LightTextTheme = TextTheme(
      displayMedium: GoogleFonts.montserrat(
        color: Colors.black87,
      ),
      titleSmall: GoogleFonts.poppins(color: Colors.black54, fontSize: 24));
  static TextTheme DarkTextTheme = TextTheme(
      displayMedium: GoogleFonts.montserrat(
        color: Colors.white70,
      ),
      titleSmall: GoogleFonts.poppins(color: Colors.white60, fontSize: 24));
}
