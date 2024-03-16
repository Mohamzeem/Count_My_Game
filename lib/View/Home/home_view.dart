import 'dart:io';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/View_Model/home_controller.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.kWhite,
        child: GetBuilder<HomeController>(
          builder: (controller) => Scaffold(
            extendBody: true,
            body: controller.getSelectedWidget(),
            bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: Colors.transparent,
              color: AppColors.mainColor,
              animationDuration: const Duration(milliseconds: 300),
              height: Platform.isAndroid ? 55 : 42,
              buttonBackgroundColor: AppColors.mainColor,
              index: controller.index,
              onTap: (value) => controller.index = value,
              items: controller.icons,
            ),
          ),
        ),
      ),
    );
  }
}
