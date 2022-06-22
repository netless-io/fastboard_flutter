import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FastThemeData {
  /// main color, used by loadings, seekbars. mostly it's configured by app main color
  final Color mainColor;

  /// for whiteboard background, loading view background
  final Color backgroundColor;

  /// reserved
  final Color selectedBackgroundColor;

  /// border color
  final Color borderColor;

  /// icons color
  final Color iconColor;

  /// text color
  final Color textColorOnBackground;

  /// divider color
  final Color dividerColor;

  FastThemeData({
    this.mainColor = const Color(0xFF3381FF),
    this.backgroundColor = const Color(0xFF000000),
    this.selectedBackgroundColor = const Color(0xFF4B4D54),
    this.borderColor = const Color(0x26CCCCCC),
    this.iconColor = const Color(0xFFFFFFFF),
    this.textColorOnBackground = const Color(0xFFF9F9F9),
    this.dividerColor = const Color(0xFFDBE1EA),
  });

  FastThemeData copyWith({
    Color? mainColor,
    Color? backgroundColor,
    Color? selectedBackgroundColor,
    Color? borderColor,
    Color? iconColor,
    Color? textColorOnBackground,
    Color? dividerColor,
  }) {
    return FastThemeData(
      mainColor: mainColor ?? this.mainColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      selectedBackgroundColor:
          selectedBackgroundColor ?? this.selectedBackgroundColor,
      borderColor: borderColor ?? this.borderColor,
      iconColor: iconColor ?? this.iconColor,
      textColorOnBackground:
          textColorOnBackground ?? this.textColorOnBackground,
      dividerColor: dividerColor ?? this.dividerColor,
    );
  }

  FastThemeData.dark()
      : this(
          mainColor: const Color(0xFF3381FF),
          backgroundColor: const Color(0xFF14181E),
          selectedBackgroundColor: const Color(0xFF4B4D54),
          borderColor: const Color(0x26CCCCCC),
          iconColor: const Color(0xFFFFFFFF),
          textColorOnBackground: const Color(0xFFECF0F7),
          dividerColor: const Color(0xFFDBE1EA),
        );

  FastThemeData.light()
      : this(
          mainColor: const Color(0xFF3381FF),
          backgroundColor: const Color(0xFFF9F9F9),
          selectedBackgroundColor: const Color(0xFFE5E8F0),
          borderColor: const Color(0x26000000),
          iconColor: const Color(0xFF000000),
          textColorOnBackground: const Color(0xFF5D5D5D),
          dividerColor: const Color(0xFFDBE1EA),
        );
}
