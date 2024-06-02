import 'package:count_my_game/Core/Widgets/custom_app_bar.dart';
import 'package:count_my_game/View/Profile/widgets/build_version_settings.dart';
import 'package:count_my_game/View/Profile/widgets/change_image.dart';
import 'package:count_my_game/View/Profile/widgets/change_name.dart';
import 'package:count_my_game/View/Profile/widgets/change_password.dart';
import 'package:count_my_game/View/Profile/widgets/delete_acc.dart';
import 'package:count_my_game/View/Profile/widgets/logout.dart';
import 'package:count_my_game/View/Profile/widgets/profile_image.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SingleChildScrollView(
        child: Column(
          children: [
            //^ appbar
            GetBuilder<AuthController>(
              builder: (controller) => CustomAppBar(
                title: 'Hello, ${controller.offlineProfile.name!}',
                photoUrl: controller.offlineProfile.isPhoto,
                isArrowBack: false,
              ),
            ),
            const ProfileImage(),
            const ChangeName(),
            const ChangePassword(),
            const ChangeImage(),
            const LogOut(),
            const DeleteAccount(),
            const BuildVerison(),
          ],
        ),
      ),
    );
  }
}
