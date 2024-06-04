import 'dart:convert';
import 'package:count_my_game/Core/Utils/functions.dart';
import 'package:count_my_game/Core/Widgets/custom_button.dart';
import 'package:count_my_game/Models/team_model.dart';
import 'package:count_my_game/View/Game/create_game_view/widgets/pick_friends_item.dart';
import 'package:count_my_game/View/Game/create_game_view/widgets/user_field.dart';
import 'package:count_my_game/View_Model/friends_controller.dart';
import 'package:count_my_game/View_Model/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_cached_image.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/View/Game/game_view/widgets/game_text_field.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class CreateTeamTwoItem extends StatelessWidget {
  const CreateTeamTwoItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isManualPhoto = false;
    final friendsCont = Get.put(FriendsController());
    return GetBuilder<GameController>(
      builder: (controller) {
        return Column(
          children: [
            //^ team number
            const CustomText(
              text: 'TEAM 2',
              color: AppColors.mainColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            //^ team name field & friends pick
            SizedBox(
              width: 150.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  friendsCont.fromFriendsTeamTwo
                      ? UserField(
                          initValue: controller.teamTwo.name == null
                              ? ''
                              : controller.teamTwo.name!,
                          width: 105.w,
                        )
                      : GameTextField(
                          lable: 'Team Name',
                          keyBoard: TextInputType.name,
                          height: 35,
                          width: 120,
                          controller: controller.teamTwoNameController,
                          maxLength: 9,
                        ),
                  const PickFriendsIcon()
                ],
              ),
            ),
            SizedBox(height: 10.h),
            //^ photo
            Container(
              width: 150.w,
              height: 100.h,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                color: AppColors.kWhite,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: friendsCont.fromFriendsTeamTwo
                  //^ pick name and photo from firebase
                  ? Padding(
                      padding: const EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CustomCachedImage(
                          isBorder: false,
                          shape: BoxShape.rectangle,
                          photoUrl: controller.teamTwo.isPhoto,
                          width: 185,
                          height: 100,
                        ),
                      ),
                    )
                  //^ pick name and photo manually
                  : InkWell(
                      onTap: () => Get.dialog(
                        AlertDialog(
                          title: const Center(
                            child: CustomText(
                              text: 'Pick image from',
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.kBlack,
                            ),
                          ),
                          actions: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    //^ image from gallary
                                    CustomButton(
                                      onPressed: () {
                                        controller
                                            .setTeamImage(
                                                pickedTeamNum: '2',
                                                source: ImageSource.gallery)
                                            .then(
                                          (value) {
                                            TeamModel teamModel = TeamModel(
                                              id: const Uuid().v4(),
                                              name: controller.teamTwoName,
                                              photo:
                                                  controller.pickedTeamTwoImage,
                                            );
                                            controller.teamTwo = teamModel;
                                          },
                                        );
                                        isManualPhoto = true;
                                        Get.back();
                                      },
                                      text: 'Gallary',
                                      width: 95,
                                      height: 30,
                                      fontSize: 16,
                                    ),
                                    //^ image from camera
                                    CustomButton(
                                      onPressed: () {
                                        controller
                                            .setTeamImage(
                                                pickedTeamNum: '2',
                                                source: ImageSource.camera)
                                            .then(
                                          (value) {
                                            TeamModel teamModel = TeamModel(
                                              id: const Uuid().v4(),
                                              name: controller.teamTwoName,
                                              photo:
                                                  controller.pickedTeamTwoImage,
                                            );
                                            controller.teamTwo = teamModel;
                                          },
                                        );
                                        isManualPhoto = true;
                                        Get.back();
                                      },
                                      text: 'Camera',
                                      width: 95,
                                      height: 30,
                                      fontSize: 16,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      child: isManualPhoto == true
                          ? GetBuilder<GameController>(
                              builder: (_) => Padding(
                                padding: const EdgeInsets.all(5),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.rectangle),
                                    width: 185.w,
                                    height: 100.h,
                                    child: Image.memory(
                                      base64Decode(
                                          controller.pickedTeamTwoImage),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomText(
                                  text: 'Set Photo',
                                  color: AppColors.kBlack,
                                  fontSize: 18,
                                ),
                                Icon(
                                  Icons.photo_camera,
                                  color: AppColors.kBlack,
                                  size: 50,
                                )
                              ],
                            ),
                    ),
            ),
            SizedBox(height: 10.h),
          ],
        );
      },
    );
  }
}

class PickFriendsIcon extends StatefulWidget {
  const PickFriendsIcon({
    super.key,
  });
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
                          height: 30.h,
                          width: 30.w,
                          decoration: const BoxDecoration(
                            color: AppColors.mainColor,
                            shape: BoxShape.circle,
                          ),
                          child: InkWell(
                            onTap: () => Get.back(),
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
                          fontSize: 18,
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
                              height: 50,
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
          if (controller.fromFriendsTeamTwo == false) {
            controller.fromFriendsTeamTwo = true;
          }
        },
        child: Container(
          height: 35.h,
          width: 25.w,
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
