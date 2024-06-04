import 'package:count_my_game/Core/Utils/animate_do.dart';
import 'package:count_my_game/View/Game/create_game_view/widgets/create_game_user_item.dart';
import 'package:count_my_game/View/Game/create_game_view/widgets/create_teamfour_item.dart';
import 'package:count_my_game/View/Game/create_game_view/widgets/create_teamthree_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:count_my_game/View/Game/create_game_view/widgets/create_teamtwo_item.dart';
import 'package:count_my_game/View_Model/game_controller.dart';

class CreatedTeams extends GetWidget<GameController> {
  const CreatedTeams({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        controller.selectedNum.value == '2'
            ? Padding(
                padding: EdgeInsets.only(bottom: 178.h),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomFadeInLeft(child: CreateGameUserItem()),
                    CustomFadeInRight(child: CreateTeamTwoItem()),
                  ],
                ),
              )
            : controller.selectedNum.value == '3'
                ? const Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomFadeInLeft(child: CreateGameUserItem()),
                          CustomFadeInRight(child: CreateTeamTwoItem()),
                        ],
                      ),
                      CustomFadeInUp(child: CreateTeamThreeItem())
                    ],
                  )
                : const Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomFadeInLeft(child: CreateGameUserItem()),
                          CustomFadeInRight(child: CreateTeamTwoItem()),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomFadeInLeft(child: CreateTeamThreeItem()),
                          CustomFadeInRight(child: CreateTeamFourItem()),
                        ],
                      ),
                    ],
                  ),
      ],
    );
  }
}
