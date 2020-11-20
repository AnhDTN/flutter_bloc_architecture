import 'package:flutter/cupertino.dart';

class AppColors {
  static final AppColors _singleton = new AppColors._internal();

  factory AppColors() {
    return _singleton;
  }
  static final white = Color(0xFFFFFFFF);
  static final black = Color(0xFF000000);
  static final primary100Color = Color(0xFFBE52F2);
  static final primary50Color = Color(0xFFDBA5F5);
  static final primary25Color = Color(0xFFEEDFF2);
  static final accent100Color = Color(0xFF6979F8);
  static final accent50Color = Color(0xFFA5AFFB);
  static final accent25Color = Color(0xFFE5E7FA);
  static final yellow100Color = Color(0xFFFFCF5C);
  static final yellow50Color = Color(0xFFFFE29D);
  static final yellow25Color = Color(0xFFFFF8E7);
  static final orange100Color = Color(0xFFFFA26B);
  static final orange50Color = Color(0xFFFFC7A6);
  static final orange25Color = Color(0xFFFFE8DA);
  static final blue100Color = Color(0xFF0084F4);
  static final blue50Color = Color(0xFF66B5F8);
  static final blue25Color = Color(0xFFD5E9FA);
  static final green100Color = Color(0xFF00C48C);
  static final green50Color = Color(0xFF7DDFC3);
  static final green25Color = Color(0xFFD5F2EA);
  static final red100Color = Color(0xFFFF647C);
  static final red50Color = Color(0xFFFDAFBB);
  static final red25Color = Color(0xFFFBE4E8);
  static final darkColor = Color(0xFF1A051D);
  static final grey100Color = Color(0xFF3F3356);
  static final grey75Color = Color(0xFFD0C9D6);
  static final grey50Color = Color(0xFFDECE9F1);
  static final grey25Color = Color(0xFFF7F5F9);
  static final startGradient1Color = Color(0xFFBD7AE3);
  static final endGradient1Color = Color(0xFF8461C9);
  static final startGradient2Color = Color(0xFFCDDDF4);
  static final endGradient2Color = Color(0xFFCDBAFA);

  AppColors._internal();
}