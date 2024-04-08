import 'dart:io';
import 'package:count_my_game/Core/Widgets/custom_button.dart';
import 'package:count_my_game/Models/team_model.dart';
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
                  friendsCont.fromFriends
                      ? UserField(
                          initValue: controller.teamTwo.name == null
                              ? ''
                              : controller.teamTwo.name!,
                          width: 150.w,
                        )
                      : GameTextField(
                          lable: 'Team Name',
                          keyBoard: TextInputType.name,
                          height: 40,
                          width: 150,
                          controller: controller.teamTwoNameController,
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
              child: friendsCont.fromFriends
                  //^ pick name and photo from firebase
                  ? InkWell(
                      // onTap: () {
                      //   AppFunctions.showBtmSheet(
                      //     isDismissible: true,
                      //     context: context,
                      //     body: [const ImageFromFirebase()],
                      //   );
                      // },
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CustomCachedImage(
                            shape: BoxShape.rectangle,
                            photoUrl: controller.teamTwo.isPhoto,
                            width: 185,
                            height: 100,
                          ),
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
                              fontSize: 22,
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
                                                source: ImageSource.gallery)
                                            .then((value) {
                                          TeamModel teamModel = TeamModel(
                                            id: const Uuid().v4(),
                                            name: controller.teamTwoName,
                                            photo: controller.pickedTeamImage,
                                          );
                                          controller.teamTwo = teamModel;
                                        });

                                        isManualPhoto = true;
                                        Get.back();
                                      },
                                      text: 'Gallary',
                                      width: 110,
                                      height: 40,
                                      fontSize: 16,
                                    ),
                                    //^ image from camera
                                    CustomButton(
                                      onPressed: () {
                                        controller.setTeamImage(
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
                                // SizedBox(height: 5.h),
                                // //^ image from firebase
                                // CustomButton(
                                //   onPressed: () {
                                //     Get.back();
                                //     isManualPhoto = true;
                                //     AppFunctions.showBtmSheet(
                                //         isDismissible: true,
                                //         context: context,
                                //         body: [const ImageFromFirebase()]);
                                //   },
                                //   text: 'Saved Images',
                                //   width: 230,
                                //   height: 40,
                                //   fontSize: 16,
                                // )
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
                                    width: 185,
                                    height: 100,
                                    child: Image.file(
                                      File(controller.pickedTeamImage),
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

class ImageFromFirebase extends StatelessWidget {
  const ImageFromFirebase({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameController>(
        builder: (controller) => Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              height: 250.h,
              child: Column(
                children: [
                  //^ arrow back and title
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
                        text: 'Pick a friend photo to add',
                        fontWeight: FontWeight.w600,
                        color: AppColors.mainColor,
                      )
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.userTeamPhotos.length,
                      itemBuilder: (context, index) {
                        final teamPhoto = controller.userTeamPhotos[index];
                        return InkWell(
                          onTap: () {
                            TeamModel teamModel = TeamModel(
                              id: controller.teamTwo.id,
                              name: controller.teamTwo.name!,
                              photo: teamPhoto,
                            );
                            controller.teamTwo = teamModel;
                            Get.back();
                          },
                          child: SizedBox(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CustomCachedImage(
                                  shape: BoxShape.rectangle,
                                  width: 350,
                                  height: 50,
                                  photoUrl: teamPhoto,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ));
  }
}
