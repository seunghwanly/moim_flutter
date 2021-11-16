import 'package:flutter/material.dart';

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
        return const TextStyle(fontWeight: FontWeight.w800, fontSize: 20);
      case CTypography.title:
        return const TextStyle(fontWeight: FontWeight.w700, fontSize: 18);
      case CTypography.headline:
        return const TextStyle(fontWeight: FontWeight.w600, fontSize: 16);
      case CTypography.body:
        return const TextStyle(fontWeight: FontWeight.w400, fontSize: 14);
      case CTypography.callOut:
        return const TextStyle(fontWeight: FontWeight.w400, fontSize: 12);
      case CTypography.subHead:
        return const TextStyle(fontWeight: FontWeight.w600, fontSize: 13);
      case CTypography.footNote:
        return const TextStyle(fontWeight: FontWeight.w400, fontSize: 11);
    }
  }
}
