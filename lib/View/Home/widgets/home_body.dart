import 'package:count_my_game/Core/Routes/app_routes.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_app_bar.dart';
import 'package:count_my_game/Core/Widgets/custom_button.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/View/Home/widgets/drop_down_widget.dart';
import 'package:count_my_game/View/Home/widgets/team_details_item.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:count_my_game/View_Model/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //^ appbar
              GetBuilder<AuthController>(
                builder: (controller) => CustomAppBar(
                  title: 'Hello, ${controller.offlineProfile.name}',
                  onTap: () => Get.toNamed(AppRoute.profileView),
                  photoUrl: controller.offlineProfile.isPhoto,
                  isArrowBack: true,
                  isProfile: true,
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
              //^ team number
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Number of teams',
                    color: AppColors.mainColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  DropDownWidget(),
                ],
              ),
              SizedBox(height: 20.h),
              //^ create game btn
              CustomButton(
                onPressed: () => controller.createNewGameFunction(),
                text: controller.isCreated ? 'Reset Number' : 'Create New Game',
                width: double.infinity,
                height: 45,
                backgroundColor: controller.isCreated
                    ? AppColors.kBlack
                    : AppColors.mainColor,
                textColor:
                    controller.isCreated ? AppColors.kWhite : AppColors.kWhite,
              ),
              SizedBox(height: 20.h),
              if (controller.isCreated) ...[
                Column(
                  children: [
                    controller.selected.value == '2'
                        ? Padding(
                            padding: EdgeInsets.only(bottom: 340.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TeamDetailsItem(
                                  photoUrl: '',
                                  teamNum: '1',
                                  controller: controller.teamOneController,
                                ),
                                TeamDetailsItem(
                                  photoUrl: '',
                                  teamNum: '2',
                                  controller: controller.teamTwoController,
                                ),
                              ],
                            ),
                          )
                        : controller.selected.value == '3'
                            ? Padding(
                                padding: EdgeInsets.only(bottom: 145.h),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TeamDetailsItem(
                                          photoUrl: '',
                                          teamNum: '1',
                                          controller:
                                              controller.teamOneController,
                                        ),
                                        TeamDetailsItem(
                                          photoUrl: '',
                                          teamNum: '2',
                                          controller:
                                              controller.teamTwoController,
                                        ),
                                      ],
                                    ),
                                    TeamDetailsItem(
                                      photoUrl: '',
                                      teamNum: '3',
                                      controller:
                                          controller.teamThreeController,
                                    ),
                                  ],
                                ),
                              )
                            : controller.selected.value == '4'
                                ? Padding(
                                    padding: EdgeInsets.only(bottom: 145.h),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TeamDetailsItem(
                                              photoUrl: '',
                                              teamNum: '1',
                                              controller:
                                                  controller.teamOneController,
                                            ),
                                            TeamDetailsItem(
                                              photoUrl: '',
                                              teamNum: '2',
                                              controller:
                                                  controller.teamTwoController,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TeamDetailsItem(
                                              photoUrl: '',
                                              teamNum: '3',
                                              controller: controller
                                                  .teamThreeController,
                                            ),
                                            TeamDetailsItem(
                                              photoUrl: '',
                                              teamNum: '4',
                                              controller:
                                                  controller.teamFourController,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink(),
                  ],
                )
              ],
              if (controller.isCreated) ...[
                CustomButton(
                  onPressed: () {},
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
