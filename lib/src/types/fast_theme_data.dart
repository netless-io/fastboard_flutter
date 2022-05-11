import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FastThemeData {
  final Color mainColor;
  final Color backgroundColor;
  final Color selectedBackgroundColor;
  final Color borderColor;
  final Color iconColor;
  final Color textColorOnBackground;
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
