import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_dialog.dart';
import 'package:count_my_game/View/Profile/widgets/profile_item.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogOut extends GetWidget<AuthController> {
  const LogOut({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileItem(
      onTap: () async => CustomDialog.twoButtonDialog(
        context: context,
        backGroundColor: AppColors.kWhite,
        textBody: 'You want to log out',
        textButton1: 'Yes',
        textButton2: 'No',
        onPressed: () {
          controller.logOut();
        },
      ),
      icon: Icons.logout_outlined,
      mainText: 'Log Out',
      suppText: 'You can log out',
    );
  }
}
