import 'package:count_my_game/Core/Routes/app_routes.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/View/Game/previous_games_view/widgets/previous_games_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PreviousGamesView extends StatefulWidget {
  const PreviousGamesView({super.key});

  @override
  State<PreviousGamesView> createState() => _PreviousGamesViewState();
}

class _PreviousGamesViewState extends State<PreviousGamesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: PreviousGamesBody(),
      ),
      //^ floating start btn
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 52.h),
        child: FloatingActionButton(
          elevation: 5,
          backgroundColor: AppColors.mainColor,
          onPressed: () => Get.toNamed(AppRoute.createdGameView),
          child: const Icon(
            Icons.play_arrow,
            color: AppColors.kWhite,
            size: 50,
          ),
        ),
      ),
    );
  }
}
