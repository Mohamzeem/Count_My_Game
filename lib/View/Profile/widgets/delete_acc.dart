import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_dialog.dart';
import 'package:count_my_game/View/Profile/widgets/profile_item.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteAccount extends GetWidget<AuthController> {
  const DeleteAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileItem(
      onTap: () async => CustomDialog.twoButtonDialog(
        context: context,
        backGroundColor: AppColors.kWhite,
        textBody: 'You want to delete account?',
        textButton1: 'Yes',
        textButton2: 'No',
        onPressed: () {
          Get.back();
          CustomDialog.twoButtonDialog(
            context: context,
            textBody: 'Are You Sure?',
            onPressed: () => controller.deleteAccount(),
            textButton1: 'Yes',
            textButton2: 'No',
          );
        },
      ),
      icon: Icons.delete_outline_outlined,
      mainText: 'Delete Account',
      suppText: 'You delete your account',
    );
  }
}
