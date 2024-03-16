import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Utils/app_strings.dart';
import 'package:count_my_game/Core/Utils/functions.dart';
import 'package:count_my_game/Core/Widgets/custom_cached_image.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/View/Game/widgets/game_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TeamDetailsItem extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final String teamNum;

  final String photoUrl;
  const TeamDetailsItem({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.teamNum,
    required this.photoUrl,
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
              GameTextField(
                lable: 'Team Name',
                keyBoard: TextInputType.name,
                height: 40,
                width: 135,
                controller: nameController,
                maxLength: 9,
              ),
              // SizedBox(width: 10.w),
              InkWell(
                onTap: () {
                  AppFunctions.showBtmSheetWithTextAndButton(
                    context: context,
                    controller: emailController,
                    title: 'Enter Email',
                    lable: 'Email',
                    buttonText: 'Add Team',
                    sheetIcon: Icons.close,
                    prefixIcon: Icons.person_2,
                    onPressedbutton: () {},
                    onTapSheetIcon: () => Get.back(),
                  );
                  // AppFunctions.showBtmSheet(
                  //     isDismissible: true,
                  //     context: context,
                  //     body: [
                  //       const CustomTextFormField(
                  //         label: 'Email',
                  //         prefixIcon: Icons.person_2,
                  //         keyBoard: TextInputType.emailAddress,
                  //       )
                  //     ]);
                },
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
        Container(
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
                    height: 170,
                    width: 100,
                  ),
                ),
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
