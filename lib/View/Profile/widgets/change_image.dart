import 'package:count_my_game/View/Profile/widgets/profile_item.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeImage extends GetWidget<AuthController> {
  const ChangeImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileItem(
      onTap: () => controller.setProfileImage(),
      icon: Icons.camera_alt_outlined,
      mainText: 'Change Image',
      suppText: 'You can change your image',
    );
  }
}
