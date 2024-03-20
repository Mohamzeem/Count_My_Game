import 'package:count_my_game/View_Model/auth_controller.dart';
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
  final bool isUser;
  const CreateTeamDetailsItem({
    super.key,
    this.nameController,
    required this.teamNum,
    required this.photoUrl,
    this.initValue = '',
    this.isUser = false,
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
        //^ team name field
        SizedBox(
          width: 170.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isUser
                  ? _isUserField(initValue: initValue)
                  : GameTextField(
                      lable: 'Team Name',
                      isRead: false,
                      keyBoard: TextInputType.name,
                      height: 40,
                      width: 135,
                      controller: nameController,
                      maxLength: 9,
                    ),
              isUser
                  ? const SizedBox.shrink()
                  : InkWell(
                      // onTap: () => AppFunctions.showBtmSheetWithTextAndButton(
                      //   context: context,
                      //   controller: emailController,
                      //   title: 'Enter Email',
                      //   lable: 'Email',
                      //   buttonText: 'Add Team',
                      //   sheetIcon: Icons.close,
                      //   prefixIcon: Icons.person_2,
                      //   onPressedbutton: () {},
                      //   onTapSheetIcon: () => Get.back(),
                      // ),
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
        isUser
            ? GetBuilder<AuthController>(
                builder: (controller) => Container(
                  width: 170.w,
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
                      photoUrl: controller.offlineProfile.isPhoto,
                      // photoUrl: FirebaseAuth.instance.currentUser!.photoURL!,
                    ),
                  ),
                ),
              )
            : Container(
                width: 170.w,
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
                        onTap: () {},
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
                          width: 170,
                          height: 100,
                        ),
                      ),
              ),
        SizedBox(height: 10.h),
      ],
    );
  }

  Widget _isUserField({String initValue = ''}) => SizedBox(
        height: 40.h,
        width: 170.w,
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
