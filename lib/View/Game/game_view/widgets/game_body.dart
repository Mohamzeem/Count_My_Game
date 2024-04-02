import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_app_bar.dart';
import 'package:count_my_game/Core/Widgets/custom_button.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/View/Game/game_view/widgets/game_teams.dart';
import 'package:count_my_game/View/Game/game_view/widgets/game_text_field.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:count_my_game/View_Model/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class GameBody extends GetWidget<GameController> {
  const GameBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          children: [
            //^ appbar
            GetBuilder<AuthController>(
              builder: (contAuth) => CustomAppBar(
                isArrowBack: false,
                title:
                    '${controller.selectedGame.value} / ${controller.maxScoreController.text}',
                photoUrl: contAuth.offlineProfile.isPhoto,
              ),
            ),
            SizedBox(height: 20.h),
            GetBuilder<GameController>(
              builder: (contGame) => Column(
                children: [
                  //^ team items
                  const GameTeams(),
                  SizedBox(height: 20.h),
                  //^ add score + field
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CustomText(
                            text: 'Add Score',
                            color: AppColors.kWhite,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                          CustomText(
                            text: 'Click on team to add score',
                            color: AppColors.kGrey200,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      GameTextField(
                        keyBoard: TextInputType.number,
                        height: 40,
                        maxLength: 3,
                        width: 70,
                        controller: controller.newScoreController,
                      )
                    ],
                  ),
                  SizedBox(height: 20.h),
                  //^info undo
                  Row(
                    children: [
                      const Icon(
                        Icons.info_outline,
                        color: AppColors.mainColor,
                      ),
                      SizedBox(width: 5.w),
                      const CustomText(
                        text: 'Double Click Team to Undo Last Added Score',
                        color: AppColors.kWhite,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  SizedBox(height: 210.h),
                  CustomButton(
                      onPressed: () => controller.closeAndDeleteGame(),
                      text: 'Close',
                      width: double.infinity,
                      height: 45)
                ],
              ),
            ),
          ],
        ));
  }
}
