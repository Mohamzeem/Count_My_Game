import 'package:count_my_game/Core/Routes/app_routes.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_cached_image.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String photoUrl;
  final void Function() onTap;
  final bool isArrowBack;
  final bool isProfile;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.onTap,
    required this.photoUrl,
    this.isArrowBack = false,
    this.isProfile = false,
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
                  onTap: () {
                    isProfile ? Get.toNamed(AppRoute.profileView) : Get.back();
                  },
                  child: Center(
                    child: Icon(
                      isProfile ? Icons.settings : Icons.arrow_back,
                      size: 25,
                      color: AppColors.kWhite,
                    ),
                  ),
                ),
              )
            : const SizedBox(height: 40, width: 40),
        SizedBox(
          width: 270.w,
          child: Center(
            child: CustomText(
              text: title,
              color: AppColors.mainColor,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              textOverflow: TextOverflow.ellipsis,
            ),
          ),
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
