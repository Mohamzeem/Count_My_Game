import 'package:count_my_game/Core/Utils/functions.dart';
import 'package:count_my_game/Core/Widgets/custom_button.dart';
import 'package:count_my_game/Core/Widgets/custom_circular_loading.dart';
import 'package:count_my_game/Models/user_friend.dart';
import 'package:count_my_game/View/Friends/widgets/friends_item.dart';
import 'package:count_my_game/View_Model/friends_controller.dart';
import 'package:count_my_game/View_Model/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Utils/app_strings.dart';
import 'package:count_my_game/Core/Widgets/custom_cached_image.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/View/Game/widgets/game_text_field.dart';
import 'package:image_picker/image_picker.dart';

class CreateGameTeamItem extends GetWidget<FriendsController> {
  final TextEditingController nameController;
  final String teamNum;
  final String photoUrl;
  final bool fromFriends;
  const CreateGameTeamItem({
    super.key,
    required this.nameController,
    required this.teamNum,
    required this.photoUrl,
    this.fromFriends = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //^ team number
        CustomText(
          text: 'Team $teamNum',
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
              GameTextField(
                lable: 'Team Name',
                keyBoard: TextInputType.name,
                height: 40,
                width: 150,
                controller: nameController,
                maxLength: 9,
              ),
              _fromFriendsIcon(context)
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
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: fromFriends
                ? Padding(
                    padding: const EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: const CustomCachedImage(
                        shape: BoxShape.rectangle,
                        photoUrl: AppStrings.defaultAppPhoto,
                        width: 185,
                        height: 100,
                      ),
                    ),
                  )
                : GetBuilder<GameController>(
                    builder: (controller) => InkWell(
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomButton(
                                  onPressed: () {
                                    controller.setProfileImage(
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
                                    controller.setProfileImage(
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
                  )),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget _fromFriendsIcon(BuildContext context) {
    return GetBuilder<FriendsController>(
      builder: (contFriends) => InkWell(
        onTap: () => AppFunctions.showBtmSheet(
          isDismissible: true,
          context: context,
          body: [
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              height: 300.h,
              width: 400.w,
              child: StreamBuilder(
                stream: contFriends.getFriends(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<FriendModel> frinedsList = snapshot.data!;
                    if (frinedsList.isEmpty || frinedsList == []) {
                      return const Center(
                        child: CustomText(
                          text: 'No Friends Found !!!',
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 25,
                        ),
                      );
                    } else {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: ListView.builder(
                          itemCount: frinedsList.length,
                          itemBuilder: (context, index) {
                            final friendModel = frinedsList[index];
                            return FriendsItem(
                              name: friendModel.name!,
                              photoUrl: friendModel.isPhoto,
                              onDismissed: (direction) {},
                            );
                          },
                        ),
                      );
                    }
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CustomCircularLoading(height: 50.h, width: 50.w),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: CustomText(
                        text: "Something went wrong !!!",
                        color: AppColors.mainColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                      ),
                    );
                  } else if (!snapshot.hasData) {
                    return const Center(
                      child: CustomText(
                        text: 'No Friends Found !!!',
                        color: AppColors.mainColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                      ),
                    );
                  } else {
                    return const Center(
                      child: CustomCircularLoading(height: 50, width: 50),
                    );
                  }
                },
              ),
            ),
          ],
        ),
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
