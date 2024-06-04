import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_cached_image.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PickFriendsItem extends StatelessWidget {
  final String name;
  final String photoUrl;
  final void Function() onTap;
  final double height;
  final bool isOnline;
  const PickFriendsItem({
    super.key,
    required this.name,
    required this.photoUrl,
    required this.onTap,
    this.isOnline = true,
    this.height = 60.0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: height.h,
        child: Card(
          surfaceTintColor: Colors.transparent,
          elevation: 5,
          color: AppColors.kWhite,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Row(
              children: [
                //^ photo
                CustomCachedImage(
                  photoUrl: photoUrl,
                ),
                SizedBox(width: 10.w),
                //^  name
                CustomText(
                  text: name,
                  fontSize: 20,
                  color: AppColors.mainColor,
                ),
                const Spacer(),
                //^ icon
                const Icon(
                  Icons.person_add,
                  color: AppColors.mainColor,
                  size: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
