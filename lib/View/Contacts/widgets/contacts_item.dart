import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_cached_image.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactsItem extends StatelessWidget {
  final String name;
  final String photoUrl;
  final void Function() onTap;
  const ContactsItem({
    super.key,
    required this.name,
    required this.photoUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: Card(
        surfaceTintColor: Colors.transparent,
        elevation: 5,
        color: AppColors.kWhite,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              CustomCachedImage(
                photoUrl: photoUrl,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 10.h,
                    width: 10.w,
                    decoration: const BoxDecoration(
                      color: AppColors.kGreen,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              CustomText(
                text: name,
                fontSize: 20,
                color: AppColors.mainColor,
              ),
              const Spacer(),
              SizedBox(width: 5.w),
              InkWell(
                onTap: onTap,
                child: const Icon(
                  Icons.delete_forever,
                  color: AppColors.mainColor,
                  size: 30,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
