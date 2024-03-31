import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:count_my_game/View_Model/game_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_cached_image.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';

class CreateGameUserItem extends StatelessWidget {
  const CreateGameUserItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return GetBuilder<GameController>(
      builder: (controller) => Column(
        children: [
          //^ team number
          const CustomText(
            text: 'Team 1',
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
                _isUserField(initValue: user.displayName!),
                const SizedBox.shrink()
              ],
            ),
          ),
          SizedBox(height: 10.h),
          //^ photo
          GetBuilder<AuthController>(
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CustomCachedImage(
                    shape: BoxShape.rectangle,
                    photoUrl: authCont.offlineProfile.isPhoto,
                  ),
                ),
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
