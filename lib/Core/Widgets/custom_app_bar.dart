import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_cached_image.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String photoUrl;
  final void Function() onTap;
  final bool isArrowBack;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.onTap,
    required this.photoUrl,
    this.isArrowBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isArrowBack
            ? Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: AppColors.mainColor,
                  shape: BoxShape.circle,
                ),
                child: InkWell(
                  onTap: () => Get.back(),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back,
                      size: 25,
                      color: AppColors.kWhite,
                    ),
                  ),
                ),
              )
            : const SizedBox(height: 40, width: 40),
        CustomText(
          text: title,
          color: AppColors.secColor,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        InkWell(
          onTap: onTap,
          child: CustomCachedImage(
            height: 45,
            width: 45,
            photoUrl: photoUrl,
          ),
        ),
      ],
    );
  }
}
