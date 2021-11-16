import 'package:flutter/material.dart';
import 'package:moim/components/color.dart';

enum CTypography {
  largeTitle,
  title,
  headline,
  body,
  callOut,
  subHead,
  footNote,
}

extension TypographyExtension on CTypography {
  TextStyle get style {
    switch (this) {
      case CTypography.largeTitle:
        return TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 20,
          color: CColor.text.color,
        );
      case CTypography.title:
        return TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: CColor.text.color,
        );
      case CTypography.headline:
        return TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: CColor.text.color,
        );
      case CTypography.body:
        return TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: CColor.text.color,
        );
      case CTypography.callOut:
        return TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 12,
          color: CColor.headline.color,
        );
      case CTypography.subHead:
        return TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: CColor.headline.color,
        );
      case CTypography.footNote:
        return TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 11,
          color: CColor.tag.color,
        );
    }
  }
}
