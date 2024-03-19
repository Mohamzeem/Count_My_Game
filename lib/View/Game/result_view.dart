import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultBody extends StatelessWidget {
  const ResultBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          Image.asset(
            'assets/images/success.png',
            color: AppColors.kGold,
          ),
          CustomText(
            text: 'Winner!',
            fontSize: 100,
            fontWeight: FontWeight.w600,
            color: AppColors.kGold,
          ),
          //todo: photo of winner then button go leave page
        ],
      ),
    );
  }
}
