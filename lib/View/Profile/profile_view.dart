import 'package:count_my_game/View/Profile/widgets/profile_body.dart';
import 'package:count_my_game/View_Model/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (_) => const SafeArea(
        child: Scaffold(
          body: ProfileBody(),
        ),
      ),
    );
  }
}
