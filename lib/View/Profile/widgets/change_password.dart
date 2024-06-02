import 'package:count_my_game/Core/Utils/functions.dart';
import 'package:count_my_game/View/Profile/widgets/profile_item.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        5.verticalSpace,
        GetBuilder<AuthController>(
          builder: (controller) => ProfileItem(
            onTap: () => AppFunctions.showBtmSheetWithTextAndButton(
              obscureText: controller.showPassword,
              suffixIconShow: true,
              context: context,
              controller: controller.passwordController,
              title: 'Enter your new password',
              lable: 'Password',
              buttonText: 'Change Password',
              sheetIcon: Icons.close,
              prefixIcon: Icons.lock,
              onPressedbutton: () => controller.changePasswordFunction(),
              onTapSheetIcon: () {
                Get.back();
                controller.passwordController.clear();
              },
              suffixIconFunction: () =>
                  controller.showPassword = !controller.showPassword,
            ),
            icon: Icons.lock_outline,
            mainText: 'Password',
            suppText: 'You can change your password',
          ),
        )
      ],
    );
  }
}
