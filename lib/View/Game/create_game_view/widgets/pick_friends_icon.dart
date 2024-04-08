import 'package:count_my_game/Core/Utils/functions.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/Models/team_model.dart';
import 'package:count_my_game/View/Game/create_game_view/widgets/pick_friends_item.dart';
import 'package:count_my_game/View_Model/friends_controller.dart';
import 'package:count_my_game/View_Model/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';

class PickFriendsIcon extends StatefulWidget {
  const PickFriendsIcon({super.key});

  @override
  State<PickFriendsIcon> createState() => _PickFriendsIconState();
}

class _PickFriendsIconState extends State<PickFriendsIcon> {
  final frinedsCont = Get.put(FriendsController());
  final gameCont = Get.put(GameController());
  @override
  void initState() {
    super.initState();
    frinedsCont.getFriendsForPick();
    gameCont.getUserTeamPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FriendsController>(
      builder: (controller) => InkWell(
        onTap: () {
          AppFunctions.showBtmSheet(
            isDismissible: true,
            context: context,
            body: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 400.h,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 40.h,
                          width: 40.w,
                          decoration: const BoxDecoration(
                            color: AppColors.mainColor,
                            shape: BoxShape.circle,
                          ),
                          child: InkWell(
                            onTap: () {
                              Get.back();
                              controller.fromFriends = !controller.fromFriends;
                            },
                            child: const Center(
                              child: Icon(
                                Icons.arrow_back,
                                size: 25,
                                color: AppColors.kWhite,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        const CustomText(
                          text: 'Pick friend to add team',
                          fontWeight: FontWeight.w600,
                          color: AppColors.mainColor,
                        )
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.frinedsList.length,
                        itemBuilder: (context, index) {
                          final friendModel = controller.frinedsList[index];
                          return GetBuilder<GameController>(
                            builder: (gameCont) => PickFriendsItem(
                              name: friendModel.name!,
                              photoUrl: friendModel.isPhoto,
                              onTap: () {
                                TeamModel teamModel = TeamModel(
                                  id: friendModel.id,
                                  name: friendModel.name,
                                  photo: friendModel.isPhoto,
                                );
                                gameCont.teamTwo = teamModel;
                                Get.back();
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
          if (controller.fromFriends == false) {
            controller.fromFriends = true;
          }
        },
        child: Container(
          height: 40.h,
          width: 28.w,
          decoration: const BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: const Icon(
            Icons.person_2,
            color: AppColors.kWhite,
            size: 25,
          ),
        ),
      ),
    );
  }
}
