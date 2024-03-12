import 'package:count_my_game/Core/Utils/functions.dart';
import 'package:count_my_game/View/Profile/widgets/settings_item.dart';
import 'package:count_my_game/View_Model/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeName extends GetView<ProfileController> {
  const ChangeName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileItem(
      onTap: () => AppFunctions.showBtmSheetWithTextAndButton(
        context: context,
        controller: controller.nameController,
        title: 'Enter your new user name',
        lable: 'User Name',
        buttonText: 'Change User Name',
        sheetIcon: Icons.close,
        prefixIcon: Icons.person,
        onPressedbutton: () => controller.changeUserNameFunction(),
        onTapSheetIcon: () => Get.back(),
      ),
      icon: Icons.person_2_outlined,
      mainText: 'User Name',
      suppText: 'You can change your User Name',
    );
  }
}
