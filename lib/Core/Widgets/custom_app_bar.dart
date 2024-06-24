import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_cached_image.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String photoUrl;
  final bool isArrowBack;
  final bool isAPhoto;

  const CustomAppBar({
    super.key,
    required this.title,
    this.isAPhoto = false,
    required this.photoUrl,
    this.isArrowBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isArrowBack
            ? Container(
                height: 45.h,
                width: 45.w,
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
            : SizedBox(height: 45.h, width: 45.w),
        SizedBox(
          width: 220.w,
          child: Center(
            child: CustomText(
              text: title,
              color: AppColors.mainColor,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              textOverflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        isAPhoto
            ? CustomCachedImage(
                height: 50,
                width: 50,
                photoUrl: photoUrl,
              )
            : SizedBox(height: 50.h, width: 50.w),
      ],
    );
  }
}
