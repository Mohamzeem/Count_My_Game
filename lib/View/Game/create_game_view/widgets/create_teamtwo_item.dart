import 'package:count_my_game/Core/Widgets/custom_button.dart';
import 'package:count_my_game/View/Game/create_game_view/widgets/pick_friends_icon.dart';
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

class CreateTeamTwoItem extends GetWidget<FriendsController> {
  final TextEditingController nameController;
  const CreateTeamTwoItem({
    super.key,
    required this.nameController,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FriendsController>(
      builder: (_) {
        return Column(
          children: [
            //^ team number
            const CustomText(
              text: 'TEAM 2',
              color: AppColors.mainColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 5.h),
            //^ team name field & friends pick
            SizedBox(
              width: 185.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  controller.fromFriends
                      ? UserField(
                          initValue: controller.friendTwo.name == null
                              ? ''
                              : controller.friendTwo.name!,
                          width: 150.w,
                        )
                      : GameTextField(
                          lable: 'Team Name',
                          keyBoard: TextInputType.name,
                          height: 40,
                          width: 150,
                          controller: nameController,
                          maxLength: 9,
                        ),
                  const PickFriendsIcon()
                  // _fromFriendsIcon(context)
                ],
              ),
            ),
            SizedBox(height: 10.h),
            //^ photo
            Container(
              width: 185.w,
              height: 100.h,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                color: AppColors.kWhite,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: controller.fromFriends
                  ? Padding(
                      padding: const EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CustomCachedImage(
                          shape: BoxShape.rectangle,
                          photoUrl: controller.friendTwo.photo == null
                              ? ''
                              : controller.friendTwo.isPhoto,
                          width: 185,
                          height: 100,
                        ),
                      ),
                    )
                  : GetBuilder<GameController>(
                      builder: (gameCont) => InkWell(
                        onTap: () => Get.dialog(
                          AlertDialog(
                            title: const Center(
                              child: CustomText(
                                text: 'Pick image from?',
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: AppColors.mainColor,
                              ),
                            ),
                            actions: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CustomButton(
                                    onPressed: () {
                                      gameCont.setProfileImage(
                                          source: ImageSource.gallery);
                                      Get.back();
                                    },
                                    text: 'Gallary',
                                    width: 110,
                                    height: 40,
                                    fontSize: 16,
                                  ),
                                  CustomButton(
                                    onPressed: () {
                                      gameCont.setProfileImage(
                                          source: ImageSource.camera);
                                      Get.back();
                                    },
                                    text: 'Camera',
                                    width: 110,
                                    height: 40,
                                    fontSize: 16,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        child: const Column(
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
            ),
            SizedBox(height: 10.h),
          ],
        );
      },
    );
  }
}
