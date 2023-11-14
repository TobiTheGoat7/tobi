import 'package:flutter/material.dart';

class AppColors {
  //Misc Colors
  static const Color scaffoldBackground = Colors.white;

  //Font Colors.
  static const Color normalTextColor = Color(0xFF757575);

  static const Color black = Colors.black;

  static const Color headerTextColor = Color(0xFF092443);
  static const Color redColor = Color(0xFFFF1B03);
  static const Color pink = Color(0xFFEFDBD9);
  static const Color hardPink = Color(0xFFF1D1D1);
  static const Color titleFontColor = Colors.black;

  static const Color greyColor = Color(0xFF8F92A1);
  static const Color greyBold = Color(0xFF596273);
  static const Color lightGreyColor = Color(0xFFC4C4C4);
  static const Color borderGreyColor = Color(0xFFCCCDD4);
  static const Color createEventBorder = Color(0xFF444242);
  static const Color white = Color(0xFFFFFFFF);
  static const Color secondaryBtnColor = Color(0xFFD1CFD7);
  static const Color secondaryBtnTextColor = Color(0xFF092443);

  //Batch Item Colors
  static const Color batchBoxColor = Color(0xFFFFFEF6);
  static const Color batchBoxShadowColor = Color(0x40DFD8D8);
  static const Color batchTitleColor = Color(0xFF022F40);
  static const Color batchAllCapsColor = Color(0xFF092443);
  static const Color batchTextButtonColor = Color(0xFF008DE0);
  static const Color dialogBackgroundColor = Color(0xFFF6F5F5);
  static const Color doneGreen = Color(0xFF32A071);
  static const Color barYellowColor = Color(0xFFF6A300);
  static const Color barGreenColor = Color(0xFF80B57F);

  /// Returns a shade of a [Color] from a double value
  ///
  /// The 'darker' boolean determines whether the shade
  /// should be .1 darker or lighter than the provided color
  static Color getShade(Color color, {bool darker = false, double value = .1}) {
    assert(value >= 0 && value <= 1, 'shade values must be between 0 and 1');

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness(
      (darker ? (hsl.lightness - value) : (hsl.lightness + value))
          .clamp(0.0, 1.0),
    );

    return hslDark.toColor();
  }

  /// Returns a [MaterialColor] from a [Color] object
  static MaterialColor getMaterialColorFromColor(Color color) {
    final colorShades = <int, Color>{
      50: getShade(color, value: 0.5),
      100: getShade(color, value: 0.4),
      200: getShade(color, value: 0.3),
      300: getShade(color, value: 0.2),
      400: getShade(color, value: 0.1),
      500: color, //Primary value
      600: getShade(color, value: 0.1, darker: true),
      700: getShade(color, value: 0.15, darker: true),
      800: getShade(color, value: 0.2, darker: true),
      900: getShade(color, value: 0.25, darker: true),
    };
    return MaterialColor(color.value, colorShades);
  }
}
