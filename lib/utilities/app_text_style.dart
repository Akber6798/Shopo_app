import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  static AppTextStyle instance = AppTextStyle();
  TextStyle textStyle(double fSize, Color fColor, FontWeight fWeight) {
    return TextStyle(fontSize: fSize.sp, color: fColor, fontWeight: fWeight);
  }
}
