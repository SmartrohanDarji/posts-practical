// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:post_flutter_practical/core/utils/widgets/app_colors.dart';
import 'package:post_flutter_practical/core/utils/widgets/styling/input_decorations.dart';

enum AppThemeEnum {
  /// Dark theme is unused in the product, only use/test LightTheme.
  DarkTheme,
  LightTheme
}

class AppThemesData {
  static final Map<AppThemeEnum, ThemeData> themeData = <AppThemeEnum, ThemeData>{
    AppThemeEnum.LightTheme: ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primaryColor,
      primaryColorLight: AppColors.primaryColor,
      primaryColorDark: AppColors.primaryColor,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.transparent,
        color: Colors.white,
        elevation: 0,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        dragHandleColor: AppColors.blackColor.withValues(alpha: .10),
        dragHandleSize: const Size(38, 4),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: Color.fromRGBO(41, 41, 52, 1)),
      ),
      fontFamily: 'Montserrat',
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: InputDecorations.labelStyleBright,
        hintStyle: InputDecorations.hintStyleBright,
        isDense: true,
      ),
      indicatorColor: AppColors.primaryColor,
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black54,
      ),
      colorScheme: ColorScheme.fromSwatch(
        backgroundColor: Colors.white,
        primarySwatch: AppColors.primarySwatches,
        accentColor: AppColors.accentColor,
      )
          .copyWith(
            secondary: AppColors.accentColor,
            primary: AppColors.primaryColor,
          )
          .copyWith(surface: Colors.white),
    ),
    AppThemeEnum.DarkTheme: ThemeData(
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.transparent,
        color: AppColors.bgColorDark,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      primaryColor: AppColors.primaryColor,
      primaryColorLight: AppColors.primaryColor,
      primaryColorDark: AppColors.primaryColor,
      scaffoldBackgroundColor: AppColors.bgColorDark,
      unselectedWidgetColor: AppColors.lightGreyColor,
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: InputDecorations.labelStyleDark,
        hintStyle: InputDecorations.hintStyleDark,
        errorStyle: const TextStyle(color: Colors.redAccent),
        isDense: true,
      ),
      fontFamily: 'Montserrat',
      indicatorColor: AppColors.primaryColor,
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white54,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: AppColors.blackColor,
      ),
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        primarySwatch: AppColors.primarySwatches,
        accentColor: AppColors.accentColor,
        backgroundColor: AppColors.bgColorDark,
      )
          .copyWith(
            secondary: AppColors.accentColor,
            surface: AppColors.bgColorDark,
            primary: AppColors.blueColor,
          )
          .copyWith(surface: AppColors.bgColorDark),
    ),
  };
}
