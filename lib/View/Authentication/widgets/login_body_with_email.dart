import 'package:count_my_game/Core/Widgets/custom_button.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/Core/Widgets/custom_text_button.dart';
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
            // 10.verticalSpace,
            //^ logo and title
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/score.png',
                  color: AppColors.mainColor,
                  height: 150.h,
                  width: double.infinity,
                ),
                const CustomText(
                  text: 'Count Your Games',
                  color: AppColors.mainColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                ),
              ],
            ),
            20.verticalSpace,
            //^ welcome text
            const CustomText(
              text: 'Welcome,',
              color: AppColors.mainColor,
              fontWeight: FontWeight.w500,
              fontSize: 25,
            ),
            //^ login text
            const CustomText(
              text: 'Log in if you have account or create a new account.',
              color: AppColors.mainColor,
              fontWeight: FontWeight.w300,
              fontSize: 18,
            ),
            15.verticalSpace,
            //^ email
            CustomTextFormField(
              label: 'Email',
              controller: controller.emailController,
              keyBoard: TextInputType.emailAddress,
              prefixIcon: Icons.email_rounded,
            ),
            10.verticalSpace,
            //^ password
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
            //^ forgot password
            Align(
              alignment: Alignment.centerRight,
              child: CustomTextButton(
                text: 'Forgot Password',
                onPressed: () => Get.toNamed(AppRoute.forgotPasswordView),
                color: AppColors.mainColor,
                fontSize: 18,
              ),
            ),
            15.verticalSpace,
            //^ login button
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
            5.verticalSpace,
            //^ create account text
            const CustomText(
              text: 'Create Account if you don\'t have account',
              color: AppColors.mainColor,
              fontWeight: FontWeight.w500,
              fontSize: 18,
              textAlign: TextAlign.center,
            ),
            5.verticalSpace,
            //^ create account button
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
            20.verticalSpace,
          ],
        ),
      ),
    );
  }
}
