import 'package:count_my_game/Core/Widgets/custom_button.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:count_my_game/View_Model/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Utils/app_strings.dart';
import 'package:count_my_game/Core/Widgets/custom_cached_image.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/View/Game/widgets/game_text_field.dart';

class CreateTeamDetailsItem extends StatelessWidget {
  final TextEditingController? nameController;
  final String teamNum;
  final String photoUrl;
  final String initValue;
  final bool fromUser;
  final bool fromFriends;
  const CreateTeamDetailsItem({
    super.key,
    this.nameController,
    required this.teamNum,
    required this.photoUrl,
    this.initValue = '',
    this.fromUser = false,
    this.fromFriends = false,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameController>(
      builder: (controller) => Column(
        children: [
          //^ team number
          CustomText(
            text: 'Team $teamNum',
            color: AppColors.mainColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 5.h),
          //^ team name field
          SizedBox(
            width: 185.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                fromUser
                    ? _isUserField(initValue: initValue)
                    : GameTextField(
                        lable: 'Team Name',
                        isRead: false,
                        keyBoard: TextInputType.name,
                        height: 40,
                        width: 150,
                        controller: nameController,
                        maxLength: 9,
                      ),
                fromUser
                    ? const SizedBox.shrink()
                    : InkWell(
                        onTap: () {},
                        child: Container(
                          height: 40.h,
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
                      )
              ],
            ),
          ),
          SizedBox(height: 10.h),
          //^ photo
          fromUser
              ? GetBuilder<AuthController>(
                  builder: (authCont) => Container(
                    width: 185.w,
                    height: 100.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: AppColors.kWhite,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: CustomCachedImage(
                        shape: BoxShape.rectangle,
                        photoUrl: authCont.offlineProfile.isPhoto,
                        // photoUrl: FirebaseAuth.instance.currentUser!.photoURL!,
                      ),
                    ),
                  ),
                )
              : Container(
                  width: 185.w,
                  height: 100.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: AppColors.kWhite,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: photoUrl == ""
                      ? InkWell(
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
                                        controller.setProfileImage(
                                            fromCamera: false);
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
                                            fromCamera: true);
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
                        )
                      : const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: CustomCachedImage(
                            shape: BoxShape.rectangle,
                            photoUrl: AppStrings.defaultAppPhoto,
                            width: 185,
                            height: 100,
                          ),
                        ),
                ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  Widget _isUserField({String initValue = ''}) => SizedBox(
        height: 40.h,
        width: 185.w,
        child: TextFormField(
          readOnly: true,
          initialValue: initValue,
          textInputAction: TextInputAction.done,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.mainColor,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
            fillColor: AppColors.kWhite,
            filled: true,
            border: OutlineInputBorder(
                borderSide: BorderSide(width: 0.5, color: AppColors.kGrey200)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0.5, color: AppColors.kGrey200)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 0.5, color: AppColors.mainColor)),
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 0.5, color: AppColors.mainColor)),
            focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 0.5, color: AppColors.mainColor)),
          ),
        ),
      );
}
