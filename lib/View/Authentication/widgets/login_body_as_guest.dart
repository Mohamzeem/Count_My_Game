import 'package:count_my_game/Core/Widgets/custom_button.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/Core/Widgets/text_form_field.dart';
import 'package:count_my_game/Core/Routes/app_routes.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/View/Authentication/widgets/auth_app_bar.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:flutter/material.dart';
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
              text:
                  'We here because your internet is off, You can login with local Database',
              color: AppColors.mainColor,
              fontWeight: FontWeight.w500,
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
              onPressed: () {},
              text: 'Start Count Your Games',
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
              text:
                  'Turn on Your Internet and Create Account to save Your games score, or log in if you have one',
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: AppColors.mainColor,
              textAlign: TextAlign.center,
            ),
            10.verticalSpace,
            CustomButton(
              onPressed: () => Get.off(AppRoute.registrationView),
              text: 'Create Account',
              width: double.infinity,
              height: 45,
              threeRadius: 5,
              lastRadius: 5,
              fontSize: 25,
              backgroundColor: AppColors.kWhite,
              textColor: AppColors.mainColor,
            ),
            SizedBox(height: 20.h),
            CustomButton(
              onPressed: () => Get.offNamed(AppRoute.emailLogInView),
              text: 'Log In',
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
