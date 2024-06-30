import 'package:count_my_game/View/Authentication/widgets/login_body_with_email.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailLoginView extends StatelessWidget {
  const EmailLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<AuthController>().navigateByConnection(context);
    return const Scaffold(
      body: LoginBodyWithEmail(),
    );
  }
}
