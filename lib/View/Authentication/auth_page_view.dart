import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthPageView extends StatelessWidget {
  const AuthPageView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<AuthController>().navigateByConnection(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset(
              'assets/images/domino-effect.png',
              color: AppColors.mainColor,
            ),
            const CustomText(
              text: 'Welcome to Count My Game \n Checking Connection...',
              textAlign: TextAlign.center,
              color: AppColors.mainColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
