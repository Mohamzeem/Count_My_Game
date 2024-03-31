import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_cached_image.dart';
import 'package:count_my_game/Core/Widgets/custom_dismiss_item.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FriendsItem extends StatelessWidget {
  final String name;
  final String photoUrl;
  final void Function(DismissDirection) onDismissed;
  final bool withIcon;
  final Color color;
  final String text;
  const FriendsItem({
    super.key,
    required this.name,
    required this.photoUrl,
    required this.onDismissed,
    this.withIcon = true,
    this.color = AppColors.kRed,
    this.text = 'Delete',
  });

  @override
  Widget build(BuildContext context) {
    return CustomDissmissItem(
      onDismissed: onDismissed,
      fontSize: 18,
      text: text,
      color: color,
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
                      decoration: const BoxDecoration(
                        color: AppColors.kGreen,
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
                SizedBox(width: 5.w),
                //^ icon
                withIcon
                    ? const Icon(
                        Icons.swipe_right_sharp,
                        color: AppColors.mainColor,
                        size: 30,
                      )
                    : const SizedBox.shrink()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
