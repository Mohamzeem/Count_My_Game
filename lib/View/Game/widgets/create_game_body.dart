import 'package:count_my_game/Core/Routes/app_routes.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_app_bar.dart';
import 'package:count_my_game/Core/Widgets/custom_button.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/View/Game/widgets/created_teams.dart';
import 'package:count_my_game/View/Game/widgets/drop_down_widget.dart';
import 'package:count_my_game/View/Game/widgets/game_text_field.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:count_my_game/View_Model/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateGameBody extends StatelessWidget {
  const CreateGameBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameController>(
      builder: (controller) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //^ appbar
              GetBuilder<AuthController>(
                builder: (controller) => CustomAppBar(
                  title: 'Create a new game',
                  photoUrl: controller.offlineProfile.isPhoto,
                  isArrowBack: true,
                ),
              ),
              SizedBox(height: 20.h),
              //^ info text
              const CustomText(
                text: 'Start Your Game', fontWeight: FontWeight.w600,
                // 'You can start a new game from here,\n set number of teams',
                color: AppColors.kWhite,
              ),
              SizedBox(height: 10.h),
              //^ game name
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Game Name',
                    color: AppColors.mainColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  DropDownWidget(isGameName: true),
                ],
              ),
              SizedBox(height: 10.h),
              //^ game score
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: 'Game Score',
                    color: AppColors.mainColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  GameTextField(
                    keyBoard: TextInputType.number,
                    maxLength: 3,
                    height: 35,
                    width: 70,
                    lable: 'Score',
                    controller: controller.maxScoreController,
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              //^ team number
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Teams Number',
                    color: AppColors.mainColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  DropDownWidget(isGameName: false),
                ],
              ),
              SizedBox(height: 20.h),
              //^ create game btn
              CustomButton(
                onPressed: () => controller.createNewGameFunction(),
                text: controller.isCreated ? 'Reset Teams' : 'Set Teams',
                width: double.infinity,
                height: 45,
                backgroundColor: controller.isCreated
                    ? AppColors.kBlack
                    : AppColors.mainColor,
                textColor:
                    controller.isCreated ? AppColors.kWhite : AppColors.kWhite,
              ),
              SizedBox(height: 20.h),
              if (controller.isCreated) ...[const CreatedTeams()],
              //^ create game btn
              if (controller.isCreated) ...[
                CustomButton(
                  onPressed: () => controller.createGameFunction(
                      idTwo: 'idTwo', idThree: 'idThree', idFour: 'idFour'),
                  text: 'Start Game',
                  width: double.infinity,
                  height: 50,
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
