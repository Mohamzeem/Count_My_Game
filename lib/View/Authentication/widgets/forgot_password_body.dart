import 'package:count_my_game/Core/Widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:count_my_game/Core/Widgets/custom_button.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/Core/Widgets/text_form_field.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';

class ForgotPasswordBody extends StatefulWidget {
  const ForgotPasswordBody({
    super.key,
  });

  @override
  State<ForgotPasswordBody> createState() => _ForgotPasswordBodyState();
}

class _ForgotPasswordBodyState extends State<ForgotPasswordBody> {
  final emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: ListView(
        children: [
          SizedBox(height: 20.h),
          Center(
            child: CustomText(
              text: 'Forgot Password',
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: AppColors.secColor,
            ),
          ),
          Image.asset(
            'assets/images/domino.png',
            scale: 2,
          ),
          // SizedBox(height: 20.h),
          CustomText(
            text: 'Please enter your Email',
            fontSize: 22,
            color: AppColors.secColor,
          ),
          SizedBox(height: 10.h),
          CustomTextFormField(
            controller: emailController,
            maxLength: 50,
            label: 'Email',
            keyBoard: TextInputType.emailAddress,
            prefixIcon: Icons.email,
          ),
          SizedBox(height: 20.h),
          CustomButton(
            onPressed: () {
              if (emailController.text == '') {
                CustomLoading.toast(text: 'Please enter email');
              } else if (!emailController.text.contains('@')) {
                CustomLoading.toast(text: 'Please enter a valid email');
              } else if (emailController.text.contains(' ')) {
                CustomLoading.toast(text: 'Email should not contain spaces');
              } else {}
            },
            text: 'Send Email',
            width: double.infinity,
            height: 45,
            threeRadius: 5,
            lastRadius: 5,
            fontSize: 25,
            backgroundColor: AppColors.mainColor,
          ),
          SizedBox(height: 20.h),
          CustomButton(
            onPressed: () => Navigator.of(context).pop(),
            text: 'Back',
            width: double.infinity,
            height: 45,
            threeRadius: 5,
            lastRadius: 5,
            fontSize: 25,
            textColor: AppColors.kWhite,
            backgroundColor: AppColors.secColor,
          ),
        ],
      ),
    );
  }
}
