import 'dart:io';
import 'package:count_my_game/Core/Widgets/custom_loading.dart';
import 'package:count_my_game/View_Model/friends_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_app_bar.dart';
import 'package:count_my_game/Core/Widgets/custom_button.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/View/Game/create_game_view/widgets/created_teams.dart';
import 'package:count_my_game/View/Game/create_game_view/widgets/drop_down_widget.dart';
import 'package:count_my_game/View/Game/game_view/widgets/game_text_field.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:count_my_game/View_Model/game_controller.dart';

class CreateGameBody extends GetWidget<GameController> {
  const CreateGameBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final friendsController = Get.put(FriendsController());
    return GetBuilder<GameController>(
      builder: (_) => Padding(
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
                text: 'Start Your Game',
                fontWeight: FontWeight.w600,
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
              //^ create teamsUi btn
              CustomButton(
                onPressed: () {
                  controller.createTeamsUi();
                  if (friendsController.fromFriendsTeamTwo == true) {
                    friendsController.fromFriendsTeamTwo = false;
                  }
                },
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
              //^ start game btn and teams
              SizedBox(
                height: Platform.isIOS ? 510.h : 490.h,
                child: controller.isCreated
                    ? Column(
                        children: [
                          const CreatedTeams(),
                          const Spacer(),
                          //^ start game btn
                          CustomButton(
                            onPressed: () {
                              if (controller.selectedNum.value == '2') {
                                controller.createTwoTeamsGameOnlineMode(
                                  twoId: controller.teamTwo.id!,
                                  twoName: controller.teamTwo.name!,
                                  twoPhoto: controller.teamTwo.photo!,
                                );
                              } else if (controller.selectedNum.value == '2') {
                                controller.createGameThreeTeamsOnlineMode(
                                  twoId: controller.teamTwo.id!,
                                  twoName: controller.teamTwo.name!,
                                  twoPhoto: controller.teamTwo.photo!,
                                  threeId: controller.teamThree.id!,
                                  threeName: controller.teamThree.name!,
                                  threePhoto: controller.teamThree.photo!,
                                );
                              } else {}
                            },
                            text: 'Start Game',
                            width: double.infinity,
                            height: 50,
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

  

  // print('#### ${controller.selectedNum}');
  // controller.onlineFunctions(
  //     controller.teamTwo.name!,
  //     controller.teamTwo.photo!,
  //     controller.teamTwo.id!);

  // controller.selectedNum.value == '2'
  //     ? await controller
  //         .createGameTwoTeamsOnlineMode(
  //         twoId: controller.teamTwo.id!,
  //         twoName: controller.teamTwo.name!,
  //         twoPhoto: controller.teamTwo.photo!,
  //       )
  //     : controller.selectedNum.value == '3'
  //         ? controller
  //             .createGameThreeTeamsOnlineMode(
  //             controller.teamTwo.name!,
  //             controller.teamThree.name!,
  //             controller.teamTwo.photo!,
  //             controller.teamThree.photo!,
  //           )
  //         : controller
  //             .createGameFourTeamsOnlineMode(
  //             controller.teamTwo.name!,
  //             controller.teamThree.name!,
  //             controller.teamFour.name!,
  //             controller.teamTwo.photo!,
  //             controller.teamThree.photo!,
  //             controller.teamFour.photo!,
  //           );

  // print(controller.teamTwo.name),
  //     controller.createGameFunction(
  // controller.teamTwo.name!,
  // controller.teamThree.name!,
  // controller.teamFour.name!,
  // controller.teamTwo.photo!,
  // controller.teamThree.photo!,
  // controller.teamFour.photo!,
  // ),