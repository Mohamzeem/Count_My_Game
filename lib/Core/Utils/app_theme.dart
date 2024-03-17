import 'package:count_my_game/Core/App/app_info.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.secColor,
    useMaterial3: true,
    fontFamily: MyApp.appFont,
  );
}
