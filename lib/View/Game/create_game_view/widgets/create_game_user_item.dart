import 'package:count_my_game/View/Game/create_game_view/widgets/user_field.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
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

    return Column(
      children: [
        //^ team number
        const CustomText(
          text: 'TEAM 1',
          color: AppColors.mainColor,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        //^ team name field & friends pick
        UserField(initValue: user.displayName!, width: 125.w),
        SizedBox(height: 10.h),
        //^ photo
        GetBuilder<AuthController>(
          builder: (authCont) => Container(
            width: 150.w,
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
                  height: 40,
                  width: 40,
                  isBorder: false,
                  shape: BoxShape.rectangle,
                  photoUrl: authCont.offlineProfile.isPhoto,
                ),
              ),
            ),
          ),
        ),
        10.verticalSpace,
      ],
    );
  }
}
