import 'package:flutter/material.dart';

enum CColor {
  blue,
  darkGreen,
  lightGreen,
  orange,
  largeTitle,
  headline,
  tag,
  bubbleOthers,
  white
}

extension ColorExtension on CColor {
  Color get color {
    switch (this) {
      case CColor.blue:
        return const Color(0xFF66B5F6);
      case CColor.darkGreen:
        return const Color(0xFF8FCACB);
      case CColor.lightGreen:
        return const Color(0xFFBFE299);
      case CColor.orange:
        return const Color(0xFFFD912E);
      case CColor.largeTitle:
        return const Color(0xFF000000);
      case CColor.headline:
        return const Color(0xFF404040);
      case CColor.tag:
        return const Color(0xFF5B5B5B);
      case CColor.bubbleOthers:
        return const Color(0xFFEFEFEF);
      case CColor.white:
        return const Color(0xFFFFFFFF);
    }
  }

  LinearGradient get gradient => LinearGradient(
        colors: [CColor.blue.color, CColor.lightGreen.color],
      );
  LinearGradient get bubbleGradient => LinearGradient(
        colors: [CColor.blue.color, CColor.lightGreen.color],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
}
