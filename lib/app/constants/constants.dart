import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BConstantColors {
  static const backgroundColor = Color(0xFF111111);
  static const homebgColor = Color(0xFFF4F6F8);
  static const txt1Color = Color(0xFF111111);
  static const txt2Color = Color(0xFF8D99AA);
  static const txt3Color = Color(0xFFFFFFFF);
  static const whiteColor = Color(0xFFFFFFFF);
}

// text style
final kPopinsBold = GoogleFonts.poppins(
    color: BConstantColors.txt1Color, fontWeight: FontWeight.w700);

final kPopinsSemiBold = GoogleFonts.poppins(
    color: BConstantColors.txt1Color, fontWeight: FontWeight.w600);

final kPopinsMedium = GoogleFonts.poppins(
    color: BConstantColors.txt1Color, fontWeight: FontWeight.w500);

final kPopinsRegular = GoogleFonts.poppins(
    color: BConstantColors.txt1Color, fontWeight: FontWeight.w400);
