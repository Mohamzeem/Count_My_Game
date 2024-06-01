import 'package:count_my_game/Core/Widgets/custom_button.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/Core/Widgets/custom_text_button.dart';
import 'package:count_my_game/Core/Widgets/text_form_field.dart';
import 'package:count_my_game/Core/Routes/app_routes.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/View/Authentication/widgets/auth_app_bar.dart';
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
            const AuthAppBar(),
            SizedBox(height: 10.h),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/score.png',
                  color: AppColors.mainColor,
                  scale: 3,
                ),
                const CustomText(
                  text: 'Count Your Games',
                  color: AppColors.mainColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                ),
              ],
            ),
            SizedBox(height: 50.h),
            const CustomText(
              text: 'Welcome,',
              color: AppColors.mainColor,
              fontWeight: FontWeight.w500,
              fontSize: 25,
            ),
            const CustomText(
              text: 'Log in if you have account or create a new account.',
              color: AppColors.mainColor,
              fontWeight: FontWeight.w500,
              fontSize: 18,
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
            Align(
              alignment: Alignment.centerRight,
              child: CustomTextButton(
                text: 'Forgot Password',
                onPressed: () => Get.toNamed(AppRoute.forgotPasswordView),
                color: AppColors.mainColor,
                fontSize: 20,
              ),
            ),
            20.verticalSpace,
            CustomButton(
              onPressed: () => controller.logInFunction(),
              text: 'Log In',
              width: double.infinity,
              height: 45,
              threeRadius: 5,
              lastRadius: 5,
              fontSize: 25,
              backgroundColor: AppColors.mainColor,
            ),
            const CustomText(
              text:
                  'ــــــــــــــــــــــــــــــــــ OR ــــــــــــــــــــــــــــــــ',
              textAlign: TextAlign.center,
              color: AppColors.mainColor,
              fontWeight: FontWeight.w700,
            ),
            const CustomText(
              text: 'Create Account if you don\'t have account',
              color: AppColors.mainColor,
              fontWeight: FontWeight.w500,
              fontSize: 20,
              textAlign: TextAlign.center,
            ),
            10.verticalSpace,
            CustomButton(
              onPressed: () => Get.toNamed(AppRoute.registrationView),
              text: 'Create Account',
              width: double.infinity,
              height: 45,
              threeRadius: 5,
              lastRadius: 5,
              fontSize: 25,
              backgroundColor: AppColors.kWhite,
              textColor: AppColors.mainColor,
            ),
          ],
        ),
      ),
    );
  }
}
