import 'package:flutter/material.dart';

EdgeInsetsGeometry space({double? horizontal, double? vertical}) =>
    EdgeInsets.symmetric(
      horizontal: horizontal ?? 0.0,
      vertical: vertical ?? 0.0,
    );