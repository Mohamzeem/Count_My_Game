import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/View/Profile/widgets/profile_body.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.kBackGround,
      body: SafeArea(child: ProfileBody()),
    );
  }
}
