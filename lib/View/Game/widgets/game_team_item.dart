import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Utils/app_strings.dart';
import 'package:count_my_game/Core/Widgets/custom_cached_image.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';

class GameDetailsItem extends StatelessWidget {
  final String teamName;
  final String score;
  final String maxScore;
  final String photoUrl;
  final VoidCallback onTap;
  final VoidCallback doubleTap;
  const GameDetailsItem({
    super.key,
    required this.teamName,
    required this.score,
    required this.photoUrl,
    required this.maxScore,
    required this.onTap,
    required this.doubleTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      onDoubleTap: doubleTap,
      child: Card(
        elevation: 10,
        surfaceTintColor: AppColors.kBackGround,
        child: Column(
          children: [
            //^ team name
            Padding(
              padding: EdgeInsets.all(5.r),
              child: CustomText(
                text: teamName,
                color: AppColors.kBlack,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            //^ photo
            Container(
              width: 170.w,
              height: 100.h,
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                // color: AppColors.kBackGround,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(5.0),
                child: CustomCachedImage(
                  shape: BoxShape.rectangle,
                  photoUrl: AppStrings.defaultAppPhoto,
                  height: 170,
                  width: 100,
                ),
              ),
            ),
            //^ score
            Padding(
              padding: EdgeInsets.all(5.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CustomText(
                    text: 'Score: ',
                    color: AppColors.kBlack,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  CustomText(
                    text: score,
                    color: AppColors.mainColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            // SizedBox(height: 10.h),
          ],
        ),
      ),
    );
  }
}
