import 'package:aqarat_raqamia/utils/text_style.dart';
import 'package:flutter/material.dart';

// ThemeData light = ThemeData(
//   fontFamily: 'Changa-regular',
//   primaryColor: Color(0xff72828A),
//   secondaryHeaderColor: Color(0xFFC4CDD2),
//   disabledColor: Color(0xFFBABFC4),
//   cardColor: Color(0xFFE84D4F),
//   splashColor: Color(0xFFEFF5F8),
//   brightness: Brightness.light,
//  // dividerColor: transparentColor,
//   hintColor: Color(0xffB6B7B7),
//   textButtonTheme: TextButtonThemeData(
//       style: TextButton.styleFrom(foregroundColor: Color(0xff72828A))), colorScheme: ColorScheme.light(
//       primary: Color(0xff72828A), secondary: Color(0xff72828A)).copyWith(surface: Color(0xFFF3F3F3)),
// );

ThemeData light = ThemeData(
  fontFamily: 'Changa-regular',
  primaryColor: Color(0xff72828A),
  secondaryHeaderColor: Color(0xFFC4CDD2),
  disabledColor: Color(0xFFBABFC4),
  dividerColor: whiteGreyColor,
  dividerTheme: DividerThemeData(
    thickness: 0.2,
    color: whiteGreyColor,
  ),
  useMaterial3: false,

  // backgroundColor: Color(0xFFF3F3F3),
  // errorColor: Color(0xFFE84D4F),
  splashColor: Color(0xFFEFF5F8),
  brightness: Brightness.light,
  hintColor: Color(0xffB6B7B7),
  cardColor: Color(0xfff2f2f2),
  colorScheme: ColorScheme.light(
    primary: Color(0xff72828A),
    secondary: Color(0xff72828A),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Color(0xff72828A),
    ),
  ),
);
