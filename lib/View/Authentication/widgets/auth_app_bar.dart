import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthAppBar extends StatelessWidget {
  final String title;
  final bool isTitle;
  final bool isArrowBack;
  const AuthAppBar({
    super.key,
    this.title = '',
    this.isTitle = true,
    this.isArrowBack = false,
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
          text: isTitle ? title : '',
          color: AppColors.mainColor,
          fontSize: 25,
          fontWeight: FontWeight.w700,
        ),
        const SizedBox(height: 40, width: 40),
      ],
    );
  }
}
