import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_circular_loading.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/Models/game_model.dart';
import 'package:count_my_game/View/Game/previous_games_view/widgets/previous_games_item.dart';
import 'package:count_my_game/View_Model/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PreviousGamesList extends StatelessWidget {
  const PreviousGamesList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameController>(
      builder: (controller) => StreamBuilder(
        stream: controller.getPreviousGames(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<GameModel> gameList = snapshot.data!
              //^ arrange list by created time
              ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
            return Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: ListView.builder(
                  itemCount: gameList.length,
                  itemBuilder: (context, index) {
                    final gameModel = gameList[index];
                    return PreviousGamesItem(
                      gameModel: gameModel,
                      onDismissed: (direction) =>
                          controller.deletePerviousGame(gameId: gameModel.id!),
                    );
                  },
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: EdgeInsets.only(top: 300.h),
              child: CustomCircularLoading(height: 50.h, width: 50.w),
            );
          } else if (snapshot.hasError) {
            return Padding(
              padding: EdgeInsets.only(top: 300.h),
              child: const CustomText(
                text: "Something went wrong !!!",
                color: AppColors.mainColor,
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),
            );
          } else if (!snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(top: 300.h),
              child: const CustomText(
                text: 'No Games Found !!!',
                color: AppColors.mainColor,
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),
            );
          } else {
            return Padding(
              padding: EdgeInsets.only(top: 300.h),
              child: const CustomCircularLoading(height: 50, width: 50),
            );
          }
        },
      ),
    );
  }
}
