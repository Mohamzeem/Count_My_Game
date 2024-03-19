import 'package:count_my_game/View/Game/result_view.dart';
import 'package:count_my_game/View/Game/widgets/game_body.dart';
import 'package:count_my_game/View_Model/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameView extends GetWidget<GameController> {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () {
            return controller.teamAPoints.value >= controller.maxScore ||
                    controller.teamBPoints.value >= controller.maxScore ||
                    controller.teamCPoints.value >= controller.maxScore ||
                    controller.teamDPoints.value >= controller.maxScore
                ? const ResultBody()
                : const GameBody();
          },
        ),
      ),
    );
  }
}
