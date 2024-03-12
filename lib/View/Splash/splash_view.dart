import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.height * 0.6,
              decoration: const BoxDecoration(),
              child: Image.asset(
                'assets/images/score.png',
                color: AppColors.mainColor,
              ),
            ),
            CustomText(
              text: 'Count Your Game Score',
              color: AppColors.secColor,
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
