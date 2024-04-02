import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_cached_image.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PickFriendsItem extends StatelessWidget {
  final String name;
  final String photoUrl;
  final void Function() onTap;

  final bool isOnline;
  const PickFriendsItem({
    super.key,
    required this.name,
    required this.photoUrl,
    required this.onTap,
    this.isOnline = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 60.h,
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
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 10.h,
                      width: 10.w,
                      decoration: BoxDecoration(
                        color: isOnline
                            ? AppColors.kGreen
                            : AppColors.secColor.withOpacity(0.7),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
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
