import 'package:count_my_game/Core/Routes/app_routes.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/View/Game/widgets/history_game_body.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:count_my_game/View_Model/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryGameView extends GetWidget<AuthController> {
  const HistoryGameView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameController>(
      init: GameController(),
      builder: (controller) => Scaffold(
        body: const SafeArea(child: HistoryGameBody()),
        //^ floating start btn
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: FloatingActionButton(
            elevation: 5,
            backgroundColor: AppColors.mainColor,
            onPressed: () => Get.toNamed(AppRoute.createdGameView),
            child: const Icon(
              Icons.play_arrow,
              color: AppColors.kWhite,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}
