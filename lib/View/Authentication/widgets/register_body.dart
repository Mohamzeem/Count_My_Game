import 'package:count_my_game/Core/Widgets/custom_button.dart';
import 'package:count_my_game/Core/Widgets/custom_loading.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/Core/Widgets/custom_text_button.dart';
import 'package:count_my_game/Core/Widgets/text_form_field.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RegisterBody extends StatelessWidget {
  const RegisterBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()),
          children: [
            SizedBox(height: 50.h),
            //^ photo & title text
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/score.png',
                  color: AppColors.mainColor,
                  scale: 3,
                ),
                Wrap(
                  children: [
                    CustomText(
                      text: 'Count Your Games',
                      color: AppColors.secColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 40,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50.h),
            //^ welcome text
            CustomText(
              text: 'Welcome,',
              color: AppColors.secColor,
              fontWeight: FontWeight.w500,
              fontSize: 25,
            ),
            //^ signin text
            CustomText(
              text: 'Sign in if you have account or create a new account.',
              color: AppColors.secColor,
              fontWeight: FontWeight.w300,
              fontSize: 20,
            ),
            SizedBox(height: 20.h),
            //^ text field username
            CustomTextFormField(
              maxLength: 50,
              label: 'User Name',
              controller: controller.nameController,
              keyBoard: TextInputType.name,
              prefixIcon: Icons.person_2,
            ),
            SizedBox(height: 10.h),
            //^ text field email
            CustomTextFormField(
              label: 'Email',
              controller: controller.emailController,
              keyBoard: TextInputType.emailAddress,
              prefixIcon: Icons.email_rounded,
            ),
            SizedBox(height: 10.h),
            //^ text field password
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
                onPressed: () => controller.register(),
                color: AppColors.secColor,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10.h),
            CustomButton(
              onPressed: () {
                if (controller.nameController.text == '') {
                  CustomLoading.toast(
                      text: 'Name required',
                      toastPosition: EasyLoadingToastPosition.center);
                } else if (controller.passwordController.text == '') {
                  CustomLoading.toast(
                      text: 'Email required',
                      toastPosition: EasyLoadingToastPosition.center);
                } else if (controller.passwordController.text == '') {
                  CustomLoading.toast(
                      text: 'Password required',
                      toastPosition: EasyLoadingToastPosition.center);
                } else {
                  controller.register();
                }
              },
              text: 'Create Account',
              width: double.infinity,
              height: 45,
              threeRadius: 5,
              lastRadius: 5,
              fontSize: 25,
              backgroundColor: AppColors.mainColor,
            ),
            SizedBox(height: 20.h),
            CustomButton(
              onPressed: () {
                Get.back();
              },
              text: 'Back',
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
