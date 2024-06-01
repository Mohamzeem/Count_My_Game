import 'dart:io';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/View_Model/game_controller.dart';
import 'package:count_my_game/View_Model/home_controller.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final gameCont = Get.put(GameController());
  @override
  void initState() {
    super.initState();
    gameCont.getPreviousGames();
    debugPrint('###### Previous Games Loaded ######');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.kWhite,
          child: GetBuilder<HomeController>(
            builder: (controller) => Scaffold(
              extendBody: true,
              body: controller.getSelectedWidget(),
              bottomNavigationBar: CurvedNavigationBar(
                backgroundColor: Colors.transparent,
                color: AppColors.secColor, //todo color
                animationDuration: const Duration(milliseconds: 300),
                height: Platform.isAndroid ? 55.h : 42.h,
                buttonBackgroundColor: AppColors.mainColor,
                index: controller.index,
                onTap: (value) => controller.index = value,
                items: controller.icons,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
