import 'package:count_my_game/Core/App/app_bindings.dart';
import 'package:count_my_game/Core/App/app_info.dart';
import 'package:count_my_game/Core/Routes/app_pages.dart';
import 'package:count_my_game/Core/Routes/app_routes.dart';
import 'package:count_my_game/Core/Utils/app_theme.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppView extends StatelessWidget {
  const AppView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController(), permanent: true);
    return ScreenUtilInit(
      designSize: AppConfig().designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: GetMaterialApp(
            builder: EasyLoading.init(),
            debugShowCheckedModeBanner: false,
            title: MyApp.appName,
            theme: appTheme(),
            defaultTransition: Transition.zoom,
            transitionDuration: const Duration(milliseconds: 300),
            initialRoute: AppRoute.initial,
            initialBinding: AppBinding(),
            getPages: AppPages.routes,
          ),
        );
      },
    );
  }
}
