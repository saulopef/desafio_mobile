import 'package:flutter/material.dart';

abstract class OneColors {
  // !Cores usadas no app
  static const Color cwbRed = Color(0xFFED1B24);
  static const Color cwbBlue = Color(0xFF24ABE3);
  static const Color cwbGreen = Color(0xFF8CC63E);

  static const Color charcoalGray = Color(0xFF3C4142);
  static const Color charcoal = Color(0xFF343837);
  static const Color charcoalDarkBlue = Color(0xFF1B2431);
  static const Color darkBlue = Color(0xFF1F3B4D);
  static const Color oceanBlue = Color(0xFF03719C);
  static const Color duskyBlue = Color(0xFF475F94);
  static const Color lightGold = Color(0xFFFDDC5C);
  static const Color yellowish = Color(0xFFFFAB0F);
  static const Color opaqueGreen = Color(0xFF0F9B8E);
  static const Color jungleGreen = Color(0xFF048243);
  static const Color greenishTeal = Color(0xFF32BF84);
  static const Color softGreen = Color(0xFF32BF84);
  static const Color lightGreen = Color(0xFFCAFFFB);
  static const Color neonRed = Color(0xFFFF073A);
  static const Color red = Color(0xFFd62828);
  static const Color orangeyRed = Color(0xFFFA4224);
  static const Color white = Color(0xffF2F2F2);
  static const Color whiteBg = Color(0xffF1FAEE);
}

abstract class OneAssets {
  static final String logo = 'assets/images/DMLogo.png';
}

// ignore: avoid_classes_with_only_static_members
abstract class OneStyles {
  static final pageTitle = TextStyle(
    fontWeight: FontWeight.bold,
    color: OneColors.charcoalGray.withAlpha(140),
  );
  static final cardTitle = TextStyle(
    fontWeight: FontWeight.bold,
    color: OneColors.charcoalGray.withAlpha(150),
  );
  static final cardLabel = TextStyle(
    // fontWeight: FontWeight.bold,
    color: OneColors.charcoalGray.withAlpha(150),
  );
  static const cardinfo = TextStyle(
    // fontWeight: FontWeight.bold,
    color: OneColors.cwbBlue,
  );
}

abstract class OneSapators {
  static const verySmall = SizedBox(height: 4, width: 4);
  static const small = SizedBox(height: 8, width: 8);
  static const medium = SizedBox(height: 16, width: 16);
  static const big = SizedBox(height: 32, width: 32);
}

Map<int, Color> customSwatch(Color color) {
  return {
    50: color.withOpacity(.1),
    100: color.withOpacity(.2),
    200: color.withOpacity(.3),
    300: color.withOpacity(.4),
    400: color.withOpacity(.5),
    500: color.withOpacity(.6),
    600: color.withOpacity(.7),
    700: color.withOpacity(.8),
    800: color.withOpacity(.9),
    900: color.withOpacity(1),
  };
}
