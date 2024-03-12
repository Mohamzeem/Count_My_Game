import 'package:count_my_game/Core/Widgets/custom_button.dart';
import 'package:count_my_game/Core/Widgets/custom_loading.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/Core/Widgets/text_form_field.dart';
import 'package:count_my_game/Core/Routes/app_routes.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginBodyAsGuest extends StatelessWidget {
  const LoginBodyAsGuest({
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
            CustomText(
              text: 'Welcome,',
              color: AppColors.secColor,
              fontWeight: FontWeight.w500,
              fontSize: 25,
            ),
            CustomText(
              text:
                  'We here because your internet is off, You can login with local Database',
              color: AppColors.secColor,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
            SizedBox(height: 10.h),
            CustomTextFormField(
              label: 'User Name',
              controller: controller.nameController,
              keyBoard: TextInputType.name,
              prefixIcon: Icons.person_2,
            ),
            SizedBox(height: 10.h),
            SizedBox(height: 10.h),
            CustomButton(
              onPressed: () {
                if (controller.emailController.text == '') {
                  CustomLoading.toast(
                      text: 'Email is required',
                      toastPosition: EasyLoadingToastPosition.center);
                } else if (controller.passwordController.text == '') {
                  CustomLoading.toast(
                      text: 'Password is required',
                      toastPosition: EasyLoadingToastPosition.center);
                } else {
                  //  controller. _clearCons();
                }
              },
              text: 'Start Count Your Games',
              width: double.infinity,
              height: 45,
              threeRadius: 5,
              lastRadius: 5,
              fontSize: 25,
              backgroundColor: AppColors.mainColor,
            ),
            SizedBox(height: 10.h),
            const Align(
              alignment: Alignment.center,
              child: CustomText(
                text: 'OR',
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),
            ),
            const Align(
              alignment: Alignment.center,
              child: CustomText(
                text:
                    'Turn on Your Internet and Create Account to save Your games score',
                fontWeight: FontWeight.w400,
                fontSize: 18,
                // textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10.h),
            CustomButton(
              onPressed: () {
                Get.offNamed(AppRoute.emailLogInView);
              },
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
