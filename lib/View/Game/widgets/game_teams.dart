import 'package:count_my_game/View/Game/widgets/game_team_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:count_my_game/View_Model/game_controller.dart';

class GameTeams extends StatelessWidget {
  const GameTeams({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameController>(
      builder: (controller) => Column(
        children: [
          controller.selectedNum.value == '2'
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GameDetailsItem(
                      doubleTap: () => controller.undoScore(team: 'A'),
                      onTap: () => controller.incrementScore(team: 'A'),
                      score: controller.teamAPoints.value.toString(),
                      photoUrl: '',
                      teamName: controller.teamOne.name!,
                      maxScore: controller.maxScoreController.text,
                    ),
                    GameDetailsItem(
                      doubleTap: () => controller.undoScore(team: 'B'),
                      onTap: () => controller.incrementScore(team: 'B'),
                      score: controller.teamBPoints.value.toString(),
                      photoUrl: '',
                      maxScore: controller.maxScoreController.text,
                      teamName: controller.teamTwo.name!,
                    ),
                  ],
                )
              : controller.selectedNum.value == '3'
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GameDetailsItem(
                              doubleTap: () => controller.undoScore(team: 'A'),
                              onTap: () => controller.incrementScore(team: 'A'),
                              score: controller.teamAPoints.value.toString(),
                              photoUrl: '',
                              maxScore: controller.maxScoreController.text,
                              teamName: controller.teamOne.name!,
                            ),
                            GameDetailsItem(
                              doubleTap: () => controller.undoScore(team: 'B'),
                              onTap: () => controller.incrementScore(team: 'B'),
                              score: controller.teamBPoints.value.toString(),
                              photoUrl: '',
                              maxScore: controller.maxScoreController.text,
                              teamName: controller.teamTwo.name!,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        GameDetailsItem(
                          doubleTap: () => controller.undoScore(team: 'C'),
                          onTap: () => controller.incrementScore(team: 'C'),
                          score: controller.teamCPoints.value.toString(),
                          photoUrl: '',
                          maxScore: controller.maxScoreController.text,
                          teamName: controller.teamThree.name!,
                        ),
                      ],
                    )
                  : controller.selectedNum.value == '4'
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GameDetailsItem(
                                  doubleTap: () =>
                                      controller.undoScore(team: 'A'),
                                  onTap: () =>
                                      controller.incrementScore(team: 'A'),
                                  score:
                                      controller.teamAPoints.value.toString(),
                                  photoUrl: controller.teamOne.isPhoto,
                                  maxScore: controller.maxScoreController.text,
                                  teamName: controller.teamOne.name!,
                                ),
                                GameDetailsItem(
                                  doubleTap: () =>
                                      controller.undoScore(team: 'B'),
                                  onTap: () =>
                                      controller.incrementScore(team: 'B'),
                                  score:
                                      controller.teamBPoints.value.toString(),
                                  photoUrl: '',
                                  maxScore: controller.maxScoreController.text,
                                  teamName: controller.teamTwo.name!,
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GameDetailsItem(
                                  doubleTap: () =>
                                      controller.undoScore(team: 'C'),
                                  onTap: () =>
                                      controller.incrementScore(team: 'C'),
                                  score:
                                      controller.teamCPoints.value.toString(),
                                  photoUrl: '',
                                  maxScore: controller.maxScoreController.text,
                                  teamName: controller.teamThree.name!,
                                ),
                                GameDetailsItem(
                                  doubleTap: () =>
                                      controller.undoScore(team: 'D'),
                                  onTap: () =>
                                      controller.incrementScore(team: 'D'),
                                  score:
                                      controller.teamDPoints.value.toString(),
                                  photoUrl: '',
                                  maxScore: controller.maxScoreController.text,
                                  teamName: controller.teamFour.name!,
                                ),
                              ],
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
