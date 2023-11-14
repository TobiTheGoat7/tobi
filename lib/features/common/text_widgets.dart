import 'package:outt/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Widget for all the Text Types on the Screens

class TitleText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final Color? textColor;
  final TextAlign? textAlign;
  final int? maxLines;
  final FontWeight? fontWeight;

  const TitleText(
    this.text, {
    Key? key,
    this.fontSize,
    this.textColor,
    this.textAlign,
    this.maxLines,
    this.fontWeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.start,
      style: GoogleFonts.dmSans(
        fontSize: fontSize ?? 24.0,
        color: textColor ?? AppColors.titleFontColor,
        fontWeight: fontWeight ?? FontWeight.w600,
      ),
    );
  }
}

///This has a fontsize of 16
///fontweight of w500
///
class NormalText extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final Color? textColor;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final int? maxLines;
  final TextDecoration? decoration;
  final String? fontFamily;

  const NormalText(
    this.text, {
    Key? key,
    this.fontSize,
    this.textColor,
    this.textAlign,
    this.fontWeight,
    this.maxLines,
    this.decoration,
    this.fontFamily,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      maxLines: maxLines ?? 1,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.start,
      style: GoogleFonts.dmSans(
        decoration: decoration,
        fontSize: fontSize ?? 16,
        color: textColor ?? AppColors.normalTextColor,
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
    );
  }
}

class SubtitleText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;

  const SubtitleText(
      {Key? key,
      required this.text,
      this.fontSize,
      this.fontWeight,
      this.textColor,
      this.textAlign,
      this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 1,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.start,
      style: GoogleFonts.mulish(
        fontWeight: fontWeight ?? FontWeight.w400,
        fontSize: fontSize ?? 15,
        color: textColor ?? Colors.black,
      ),
    );
  }
}

class AccentText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final TextAlign? textAlign;
  final int? maxLines;

  const AccentText(
      {Key? key,
      required this.text,
      this.fontSize,
      this.textColor,
      this.textAlign,
      this.maxLines,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 1,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.start,
      style: GoogleFonts.mulish(
        fontSize: 20,
        color: textColor ?? Colors.black,
        fontWeight: fontWeight ?? FontWeight.w400,
      ),
    );
  }
}

class SmallText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final double? fontSize;
  final Color? textColor;
  final TextAlign? textAlign;
  final int? maxLines;

  const SmallText(
      {Key? key,
      required this.text,
      this.fontSize,
      this.textColor,
      this.textAlign,
      this.maxLines,
      this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 1,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.start,
      style: GoogleFonts.mulish(
        fontSize: 10,
        fontWeight: fontWeight ?? FontWeight.w700,
        color: textColor ?? Colors.black,
      ),
    );
  }
}
