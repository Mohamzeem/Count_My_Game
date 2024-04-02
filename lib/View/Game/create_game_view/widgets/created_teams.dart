import 'package:count_my_game/View/Game/create_game_view/widgets/create_game_user_item.dart';
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
                padding: EdgeInsets.only(bottom: 0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CreateGameUserItem(),
                    CreateTeamTwoItem(
                      nameController: controller.teamTwoNameController,
                    ),
                  ],
                ),
              )
            : controller.selectedNum.value == '3'
                ? Padding(
                    padding: EdgeInsets.only(bottom: 0.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CreateGameUserItem(),
                            CreateTeamTwoItem(
                              nameController: controller.teamTwoNameController,
                            ),
                          ],
                        ),
                        // CreateTeamTwoItem(
                        //   photoUrl: '',
                        //   teamNum: '3',
                        //   nameController: controller.teamThreeNameController,
                        // ),
                      ],
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(bottom: 0.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const CreateGameUserItem(),
                            CreateTeamTwoItem(
                              nameController: controller.teamTwoNameController,
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // CreateTeamTwoItem(
                            //   photoUrl: '',
                            //   teamNum: '3',
                            //   nameController:
                            //       controller.teamThreeNameController,
                            // ),
                            // CreateTeamTwoItem(
                            //   photoUrl: '',
                            //   teamNum: '4',
                            //   nameController:
                            //       controller.teamFourNameController,
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
      ],
    );
  }
}