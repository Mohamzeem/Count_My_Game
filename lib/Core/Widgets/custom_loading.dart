import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CustomLoading {
  CustomLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 40.0
      ..lineWidth = 2
      ..radius = 10.0
      ..progressColor = AppColors.kWhite
      ..backgroundColor = AppColors.mainColor
      ..indicatorColor = AppColors.kWhite
      ..textColor = AppColors.kWhite
      ..maskColor = Colors.transparent
      ..userInteractions = true
      ..dismissOnTap = true
      ..fontSize = 20
      ..maskType = EasyLoadingMaskType.black;
  }

  static void show({String? text}) {
    EasyLoading.instance.userInteractions = true;
    EasyLoading.show(status: text ?? 'Loading...');
  }

  static void toast(
      {required String text, EasyLoadingToastPosition? toastPosition}) {
    EasyLoading.showToast(
      text,
      dismissOnTap: true,
      maskType: EasyLoadingMaskType.none,
      toastPosition: toastPosition,
    );
  }

  static void dismiss() {
    EasyLoading.instance.userInteractions = true;
    EasyLoading.dismiss();
  }
}
