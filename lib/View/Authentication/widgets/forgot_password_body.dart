import 'package:count_my_game/Core/Widgets/custom_loading.dart';
import 'package:count_my_game/View/Authentication/widgets/auth_app_bar.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:count_my_game/Core/Widgets/custom_button.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/Core/Widgets/text_form_field.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:get/get.dart';

class ForgotPasswordBody extends StatelessWidget {
  const ForgotPasswordBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ListView(
        children: [
          const AuthAppBar(
            isArrowBack: true,
            isTitle: true,
            title: 'Forgot Password',
          ),
          10.verticalSpace,
          Image.asset(
            'assets/images/loser.png',
            scale: 2,
          ),
          const CustomText(
            text: 'Please enter your Email',
            fontSize: 22,
            color: AppColors.mainColor,
          ),
          10.verticalSpace,
          CustomTextFormField(
            controller: controller.emailController,
            maxLength: 50,
            label: 'Email',
            keyBoard: TextInputType.emailAddress,
            prefixIcon: Icons.email,
          ),
          20.verticalSpace,
          CustomButton(
            onPressed: () {
              if (controller.emailController.text == '') {
                CustomLoading.toast(text: 'Please enter email');
              } else if (!controller.emailController.text.contains('@')) {
                CustomLoading.toast(text: 'Please enter a valid email');
              } else if (controller.emailController.text.contains(' ')) {
                CustomLoading.toast(text: 'Email should not contain spaces');
              } else {
                controller.forgotPassword();
              }
            },
            text: 'Send Email',
            width: double.infinity,
            height: 45,
            threeRadius: 5,
            lastRadius: 5,
            fontSize: 25,
            backgroundColor: AppColors.mainColor,
          ),
        ],
      ),
    );
  }
}
