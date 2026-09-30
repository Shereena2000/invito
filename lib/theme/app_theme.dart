import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  static const Color cream = Color(0xFFFBF6F0);
  static const Color stone = Color(0xFFEDEAE3);
  static const Color graphite = Color(0xFF4A4642);
  static const Color charcoal = Color(0xFF232120);
  static const Color gold = Color(0xFFC9A66B);
  static const Color softGold = Color(0xFFE7D7B8);
  static const Color ivory = Color(0xFFFFFDF9);
}

class AppText {
  AppText._();

  static TextStyle script(double size, {Color? color}) => GoogleFonts.greatVibes(
        fontSize: size,
        color: color ?? AppColors.graphite,
        height: 1.1,
      );

  static TextStyle heading(double size, {Color? color, FontWeight? weight}) =>
      GoogleFonts.playfairDisplay(
        fontSize: size,
        color: color ?? AppColors.charcoal,
        fontWeight: weight ?? FontWeight.w600,
        letterSpacing: 0.5,
      );

  static TextStyle body(double size, {Color? color, FontWeight? weight}) => GoogleFonts.lato(
        fontSize: size,
        color: color ?? AppColors.charcoal.withValues(alpha: 0.75),
        fontWeight: weight ?? FontWeight.normal,
        height: 1.6,
      );

  static TextStyle label(double size, {Color? color, FontWeight? weight}) => GoogleFonts.lato(
        fontSize: size,
        color: color ?? AppColors.gold,
        fontWeight: weight ?? FontWeight.w600,
        letterSpacing: 4,
      );
}

class AppBreakpoints {
  AppBreakpoints._();

  static const double mobile = 700;
  static const double tablet = 1080;

  static bool isMobile(double width) => width < mobile;
  static bool isTablet(double width) => width >= mobile && width < tablet;
  static bool isDesktop(double width) => width >= tablet;
}
