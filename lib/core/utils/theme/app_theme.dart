import 'package:flutter/material.dart';

import 'package:shoply_app_dashboard/core/utils/fonts/app_fonts.dart';
import 'package:shoply_app_dashboard/core/utils/theme/app_colors.dart';

class AppTheme {
  static ThemeData themeLight = ThemeData(
    fontFamily: AppFonts.quikSand,
    scaffoldBackgroundColor: AppColors.backgrroundLight,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryColor,
      onPrimary: Colors.black,
      secondary: AppColors.primaryColor,
      onSecondary: AppColors.onPrimary,
      error: AppColors.error,
      onError: AppColors.onError,
      surface: AppColors.backgrroundLight,
      onSurface: Colors.black,
    ),
    radioTheme: RadioThemeData(fillColor: WidgetStatePropertyAll(Colors.black)),
    iconTheme: IconThemeData(color: Colors.black),
    listTileTheme: ListTileThemeData(
      iconColor: Colors.black,
      textColor: Colors.black,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontStyle: FontStyle.normal,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
    ),
    cardColor: Colors.grey.shade100,
    dividerColor: Colors.black.withValues(alpha: .2),
  );

  static ThemeData themeDark = ThemeData(
    fontFamily: AppFonts.quikSand,
    scaffoldBackgroundColor: AppColors.backgrrounDark,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryColorDark,
      onPrimary: AppColors.textColorDark,
      secondary: AppColors.primaryColorDark,
      onSecondary: AppColors.textColorDark,
      error: AppColors.error,
      onError: AppColors.onError,
      surface: AppColors.backgrrounDark,
      onSurface: Colors.white,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xff181818),
    ),
    radioTheme: RadioThemeData(fillColor: WidgetStatePropertyAll(Colors.white)),
    listTileTheme: ListTileThemeData(
      iconColor: Colors.white,
      textColor: Colors.white,
    ),
    iconTheme: IconThemeData(color: Colors.white),
    textTheme: TextTheme(
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontStyle: FontStyle.normal,
      ),
    ),
    cardColor: Color(0xff1E1E1E),
    dividerColor: Colors.white.withValues(alpha: .2),
  );
}
