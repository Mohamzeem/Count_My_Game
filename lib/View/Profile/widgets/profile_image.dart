import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_cached_image.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
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
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.kWhite.withOpacity(0.4),
            blurRadius: 5,
            spreadRadius: 5,
          ),
        ],
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
            photoUrl: controller.offlineProfile.isPhoto,
            height: 150,
            width: 150,
          ),
        ),
      ),
    );
  }
}
