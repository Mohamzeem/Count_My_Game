import 'package:count_my_game/Core/Routes/app_routes.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_app_bar.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:count_my_game/View_Model/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HistoryGameView extends StatelessWidget {
  const HistoryGameView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameController>(
      init: GameController(),
      builder: (controller) => Scaffold(
        body: const SafeArea(
          child: HistoryGameBody(),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: FloatingActionButton.extended(
            backgroundColor: AppColors.kWhite,
            onPressed: () => Get.toNamed(AppRoute.createdGameView),
            label: const Row(
              children: [
                CustomText(
                  text: 'New Game',
                  color: AppColors.mainColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HistoryGameBody extends StatelessWidget {
  const HistoryGameBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          //^ appbar
          GetBuilder<AuthController>(
            builder: (controller) => CustomAppBar(
              title: controller.offlineProfile.name!,
              onTap: () {},
              photoUrl: controller.offlineProfile.isPhoto,
              isArrowBack: false,
              isProfile: false,
            ),
          ),
          const CustomText(text: "HISTORY GAME VIEW"),
        ],
      ),
    );
  }
}
