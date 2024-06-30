import 'package:count_my_game/Core/Widgets/custom_app_bar.dart';
import 'package:count_my_game/View/Game/previous_games_view/widgets/previous_games_list.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PreviousGamesBody extends StatelessWidget {
  const PreviousGamesBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          //^ appbar
          GetBuilder<AuthController>(
            builder: (controller) => CustomAppBar(
              title: 'Game History',
              photoUrl: FirebaseAuth.instance.currentUser!.photoURL!,
              isArrowBack: false,
              isAPhoto: true,
            ),
          ),
          const PreviousGamesList(),
        ],
      ),
    );
  }
}
