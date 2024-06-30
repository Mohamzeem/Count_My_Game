import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_cached_image.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Card(
        elevation: 5,
        color: AppColors.kWhite,
        surfaceTintColor: AppColors.kWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
          side: const BorderSide(color: AppColors.kWhite),
        ),
        child: GetBuilder<AuthController>(
          builder: (controller) => CustomCachedImage(
            photoUrl: FirebaseAuth.instance.currentUser!.photoURL!,
            // photoUrl: controller.userImg,
            height: 150,
            width: 150,
          ),
        ),
      ),
    );
  }
}
