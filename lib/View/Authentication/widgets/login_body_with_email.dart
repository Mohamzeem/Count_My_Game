import 'package:count_my_game/Core/Widgets/custom_button.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/Core/Widgets/text_form_field.dart';
import 'package:count_my_game/Core/Routes/app_routes.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginBodyWithEmail extends StatelessWidget {
  const LoginBodyWithEmail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          children: [
            SizedBox(height: 50.h),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/score.png',
                  color: AppColors.mainColor,
                  scale: 3,
                ),
                CustomText(
                  text: 'Count Your Games',
                  color: AppColors.secColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                ),
              ],
            ),
            SizedBox(height: 50.h),
            CustomText(
              text: 'Welcome,',
              color: AppColors.secColor,
              fontWeight: FontWeight.w500,
              fontSize: 25,
            ),
            CustomText(
              text: 'Sign in if you have account or create a new account.',
              color: AppColors.secColor,
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
            SizedBox(height: 20.h),
            CustomTextFormField(
              label: 'Email',
              controller: controller.emailController,
              keyBoard: TextInputType.emailAddress,
              prefixIcon: Icons.email_rounded,
            ),
            SizedBox(height: 10.h),
            CustomTextFormField(
              label: 'Password',
              controller: controller.passwordController,
              keyBoard: TextInputType.emailAddress,
              prefixIcon: Icons.lock,
              obscureText: controller.showPassword,
              suffixIconShow: true,
              suffixIconFunction: () =>
                  controller.showPassword = !controller.showPassword,
            ),
            SizedBox(height: 40.h),
            CustomButton(
              onPressed: () => controller.logInFunction(),
              text: 'Sign In',
              width: double.infinity,
              height: 45,
              threeRadius: 5,
              lastRadius: 5,
              fontSize: 25,
              backgroundColor: AppColors.mainColor,
            ),
            SizedBox(height: 20.h),
            CustomButton(
              onPressed: () => Get.toNamed(AppRoute.registrationView),
              text: 'Create Account',
              width: double.infinity,
              height: 45,
              threeRadius: 5,
              lastRadius: 5,
              fontSize: 25,
              backgroundColor: AppColors.secColor,
              textColor: AppColors.kWhite,
            ),
          ],
        ),
      ),
    );
  }
}
