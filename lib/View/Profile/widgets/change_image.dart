import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_button.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/View/Profile/widgets/profile_item.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChangeImage extends GetWidget<AuthController> {
  const ChangeImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ProfileItem(
      onTap: () => Get.dialog(
        AlertDialog(
          title: const Center(
              child: CustomText(
            text: 'Pick image from?',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.mainColor,
          )),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  onPressed: () {
                    controller.setProfileImage(source: ImageSource.gallery);
                    Get.back();
                  },
                  text: 'Gallary',
                  width: 110,
                  height: 40,
                  fontSize: 16,
                ),
                CustomButton(
                  onPressed: () {
                    controller.setProfileImage(source: ImageSource.camera);
                    Get.back();
                  },
                  text: 'Camera',
                  width: 110,
                  height: 40,
                  fontSize: 16,
                ),
              ],
            ),
          ],
        ),
      ),
      // onTap: () => controller.setProfileImage(fromCamera: false),
      icon: Icons.camera_alt_outlined,
      mainText: 'Change Image',
      suppText: 'You can change your image',
    );
  }
}
