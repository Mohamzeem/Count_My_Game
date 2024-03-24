import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:count_my_game/View/Game/widgets/create_game_team_item.dart';
import 'package:count_my_game/View_Model/game_controller.dart';

class CreatedTeams extends GetWidget<GameController> {
  const CreatedTeams({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String userName = FirebaseAuth.instance.currentUser!.displayName!;
    return Column(
      children: [
        controller.selectedNum.value == '2'
            ? Padding(
                padding: EdgeInsets.only(bottom: 0.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CreateTeamDetailsItem(
                      initValue: userName,
                      isUser: true,
                      photoUrl: '',
                      teamNum: '1',
                    ),
                    CreateTeamDetailsItem(
                      photoUrl: '',
                      teamNum: '2',
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
                            CreateTeamDetailsItem(
                              initValue: userName,
                              isUser: true,
                              photoUrl: '',
                              teamNum: '1',
                            ),
                            CreateTeamDetailsItem(
                              photoUrl: '',
                              teamNum: '2',
                              nameController: controller.teamTwoNameController,
                            ),
                          ],
                        ),
                        CreateTeamDetailsItem(
                          photoUrl: '',
                          teamNum: '3',
                          nameController: controller.teamThreeNameController,
                        ),
                      ],
                    ),
                  )
                : controller.selectedNum.value == '4'
                    ? Padding(
                        padding: EdgeInsets.only(bottom: 0.h),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CreateTeamDetailsItem(
                                  isUser: true,
                                  initValue: userName,
                                  photoUrl: '',
                                  teamNum: '1',
                                ),
                                CreateTeamDetailsItem(
                                  photoUrl: '',
                                  teamNum: '2',
                                  nameController:
                                      controller.teamTwoNameController,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CreateTeamDetailsItem(
                                  photoUrl: '',
                                  teamNum: '3',
                                  nameController:
                                      controller.teamThreeNameController,
                                ),
                                CreateTeamDetailsItem(
                                  photoUrl: '',
                                  teamNum: '4',
                                  nameController:
                                      controller.teamFourNameController,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
      ],
    );
  }
}
