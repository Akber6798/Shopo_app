import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopo/const/app_colors.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: scaffoldColor,
  primaryColor: cardColor,
  appBarTheme: AppBarTheme(
    iconTheme: IconThemeData(
      color: iconsColor,
    ),
    backgroundColor: scaffoldColor,
    centerTitle: true,
    titleTextStyle: TextStyle(
        color: textColor, fontSize: 22.sp, fontWeight: FontWeight.bold),
    elevation: 0,
  ),
  iconTheme: IconThemeData(
    color: iconsColor,
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.black,
    selectionColor: Colors.blue,
  ),
  cardColor: cardColor,
  brightness: Brightness.light,
  colorScheme: ThemeData().colorScheme.copyWith(
        secondary: iconsColor,
        brightness: Brightness.light,
      ),
);
