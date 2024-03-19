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
                padding: EdgeInsets.only(bottom: 250.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TeamDetailsItem(
                      initValue: userName,
                      isUser: true,
                      emailController: controller.emailController,
                      photoUrl: '',
                      teamNum: '1',
                      nameController: controller.teamOneController,
                    ),
                    TeamDetailsItem(
                      emailController: controller.emailController,
                      photoUrl: '',
                      teamNum: '2',
                      nameController: controller.teamTwoController,
                    ),
                  ],
                ),
              )
            : controller.selectedNum.value == '3'
                ? Padding(
                    padding: EdgeInsets.only(bottom: 58.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TeamDetailsItem(
                              initValue: userName,
                              isUser: true,
                              emailController: controller.emailController,
                              photoUrl: '',
                              teamNum: '1',
                              nameController: controller.teamOneController,
                            ),
                            TeamDetailsItem(
                              emailController: controller.emailController,
                              photoUrl: '',
                              teamNum: '2',
                              nameController: controller.teamTwoController,
                            ),
                          ],
                        ),
                        TeamDetailsItem(
                          emailController: controller.emailController,
                          photoUrl: '',
                          teamNum: '3',
                          nameController: controller.teamThreeController,
                        ),
                      ],
                    ),
                  )
                : controller.selectedNum.value == '4'
                    ? Padding(
                        padding: EdgeInsets.only(bottom: 58.h),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TeamDetailsItem(
                                  isUser: true,
                                  initValue: userName,
                                  emailController: controller.emailController,
                                  photoUrl: '',
                                  teamNum: '1',
                                  nameController: controller.teamOneController,
                                ),
                                TeamDetailsItem(
                                  emailController: controller.emailController,
                                  photoUrl: '',
                                  teamNum: '2',
                                  nameController: controller.teamTwoController,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TeamDetailsItem(
                                  emailController: controller.emailController,
                                  photoUrl: '',
                                  teamNum: '3',
                                  nameController:
                                      controller.teamThreeController,
                                ),
                                TeamDetailsItem(
                                  emailController: controller.emailController,
                                  photoUrl: '',
                                  teamNum: '4',
                                  nameController: controller.teamFourController,
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
