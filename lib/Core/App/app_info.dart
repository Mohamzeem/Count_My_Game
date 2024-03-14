import 'dart:io';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

class MyApp {
  MyApp._();

  static String appName = 'CountMyGame';
  static String appFont = 'Cairo';

//~ appbar states
  static void setSystemUi() {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
        statusBarColor: AppColors.kBackGround,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: AppColors.kBackGround,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}

//~ screen utiles size
class AppConfig {
  AppConfig();
  final Size designSize = const Size(411.42857142857144, 867.4285714285714);
}

//~ to get system app info and app version build
class AppInfoUtil {
  Future<String> getAppVersion(BuildContext context) async {
    String buildNumberText = "";
    var packageInfo = await PackageInfo.fromPlatform();
    buildNumberText = '${packageInfo.version} (${packageInfo.buildNumber})';
    return buildNumberText;
  }
}
