import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle inter(
    Color color, double size, FontWeight fw, TextDecoration? decor) {
  return GoogleFonts.inter(
      color: color, fontSize: size, fontWeight: fw, decoration: decor);
}
