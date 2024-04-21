import 'package:count_my_game/View/Game/game_view/widgets/game_team_item.dart';
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
    // final friendsController = Get.put(FriendsController());
    return GetBuilder<GameController>(
      builder: (controller) => Column(
        children: [
          controller.selectedNum.value == '2'
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GameTeamsItem(
                      isUser: true,
                      doubleTap: () => controller.undoScore(team: 'A'),
                      onTap: () => controller.incrementScore(team: 'A'),
                      score: controller.teamAPoints.value.toString(),
                      photoUrl: controller.gameModel.teams![0].isPhoto,
                      teamName: controller.gameModel.teams![0].name!,
                    ),
                    GameTeamsItem(
                      doubleTap: () => controller.undoScore(team: 'B'),
                      onTap: () {
                        controller.incrementScore(team: 'B');
                      },
                      score: controller.teamBPoints.value.toString(),
                      photoUrl: controller.gameModel.teams![1].isPhoto,
                      teamName: controller.gameModel.teams![1].name!,
                    ),
                  ],
                )
              : controller.selectedNum.value == '3'
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GameTeamsItem(
                              isUser: true,
                              isTwoTeams: false,
                              doubleTap: () => controller.undoScore(team: 'A'),
                              onTap: () => controller.incrementScore(team: 'A'),
                              score: controller.teamAPoints.value.toString(),
                              photoUrl: controller.gameModel.teams![0].isPhoto,
                              teamName: controller.gameModel.teams![0].name!,
                            ),
                            GameTeamsItem(
                              isTwoTeams: false,
                              doubleTap: () => controller.undoScore(team: 'B'),
                              onTap: () {
                                controller.incrementScore(team: 'B');
                              },
                              score: controller.teamBPoints.value.toString(),
                              photoUrl: controller.gameModel.teams![1].isPhoto,
                              teamName: controller.gameModel.teams![1].name!,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        GameTeamsItem(
                          doubleTap: () => controller.undoScore(team: 'C'),
                          onTap: () => controller.incrementScore(team: 'C'),
                          score: controller.teamCPoints.value.toString(),
                          photoUrl: controller.gameModel.teams![2].isPhoto,
                          teamName: controller.gameModel.teams![2].name!,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GameTeamsItem(
                              isTwoTeams: false,
                              isUser: true,
                              doubleTap: () => controller.undoScore(team: 'A'),
                              onTap: () => controller.incrementScore(team: 'A'),
                              score: controller.teamAPoints.value.toString(),
                              photoUrl: controller.gameModel.teams![0].isPhoto,
                              teamName: controller.gameModel.teams![0].name!,
                            ),
                            GameTeamsItem(
                              isTwoTeams: false,
                              doubleTap: () => controller.undoScore(team: 'B'),
                              onTap: () {
                                controller.incrementScore(team: 'B');
                              },
                              score: controller.teamBPoints.value.toString(),
                              photoUrl: controller.gameModel.teams![1].isPhoto,
                              teamName: controller.gameModel.teams![1].name!,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GameTeamsItem(
                              isTwoTeams: false,
                              doubleTap: () => controller.undoScore(team: 'C'),
                              onTap: () => controller.incrementScore(team: 'C'),
                              score: controller.teamCPoints.value.toString(),
                              photoUrl: controller.gameModel.teams![2].isPhoto,
                              teamName: controller.gameModel.teams![2].name!,
                            ),
                            GameTeamsItem(
                              isTwoTeams: false,
                              doubleTap: () => controller.undoScore(team: 'D'),
                              onTap: () => controller.incrementScore(team: 'D'),
                              score: controller.teamDPoints.value.toString(),
                              photoUrl: controller.gameModel.teams![3].isPhoto,
                              teamName: controller.gameModel.teams![3].name!,
                            ),
                          ],
                        ),
                      ],
                    ),
        ],
      ),
    );
  }
}
