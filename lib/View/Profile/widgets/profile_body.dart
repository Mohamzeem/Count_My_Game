import 'package:count_my_game/Core/Widgets/custom_app_bar.dart';
import 'package:count_my_game/View/Profile/widgets/build_version_settings.dart';
import 'package:count_my_game/View/Profile/widgets/change_image.dart';
import 'package:count_my_game/View/Profile/widgets/change_name.dart';
import 'package:count_my_game/View/Profile/widgets/change_password.dart';
import 'package:count_my_game/View/Profile/widgets/logout.dart';
import 'package:count_my_game/View/Profile/widgets/profile_image.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:count_my_game/View_Model/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileBody extends GetWidget<ProfileController> {
  const ProfileBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AuthController auth = Get.find();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            //^ hello + user name
            CustomAppBar(
              title: auth.offlineProfile.name!,
              onTap: () {},
              photoUrl: auth.offlineProfile.isPhoto,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: CustomText(
            //     text: 'Hello, ${controller.auth.currentUser!.displayName}',
            //     fontSize: 25,
            //     color: AppColors.mainColor,
            //   ),
            // ),
            SizedBox(height: 20.h),
            const ProfileImage(),
            SizedBox(height: 20.h),
            const ChangeName(),
            SizedBox(height: 5.h),
            const ChangePassword(),
            SizedBox(height: 5.h),
            const ChangeImage(),
            SizedBox(height: 5.h),
            const LogOut(),
            SizedBox(height: 5.h),
            const BuildVerison(),
          ],
        ),
      ),
    );
  }
}
