import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_circular_loading.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/Models/game_model.dart';
import 'package:count_my_game/View_Model/game_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PreviousGamesList extends StatelessWidget {
  const PreviousGamesList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GameController>(
      builder: (controller) => StreamBuilder(
        stream: controller.getPreviousGames(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final List<GameModel> gameList = snapshot.data!;
            // ..sort(
            //   (a, b) => a.createdAt!.compareTo(b.createdAt!),
            // );
            return Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: ListView.builder(
                  itemCount: gameList.length,
                  itemBuilder: (context, index) {
                    final gameModel = gameList[index];
                    return PreviousGamesItem(gameModel: gameModel);
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

class PreviousGamesItem extends StatelessWidget {
  final GameModel gameModel;
  const PreviousGamesItem({
    super.key,
    required this.gameModel,
  });

  @override
  Widget build(BuildContext context) {
    DateTime inputTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(gameModel.createdAt!));
    String formattedTime = DateFormat('dd/MM/yyyy h:mm a').format(inputTime);
    bool winner = gameModel.winner == FirebaseAuth.instance.currentUser!.uid;

    return Card(
      surfaceTintColor: Colors.transparent,
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.kBackGround,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ExpansionTile(
          title: Row(
            children: [
              winner
                  ? SvgPicture.asset(
                      height: 40,
                      'assets/images/winner.svg',
                      colorFilter:
                          ColorFilter.mode(Colors.amber[300]!, BlendMode.srcIn),
                    )
                  : SvgPicture.asset(
                      height: 40,
                      'assets/images/loser.svg',
                      colorFilter: const ColorFilter.mode(
                          AppColors.kRed, BlendMode.srcIn),
                    ),
              const SizedBox(width: 8),
              CustomText(
                text: gameModel.name!,
                color: AppColors.mainColor,
                fontSize: 22,
              ),
            ],
          ),
          iconColor: AppColors.mainColor,
          collapsedIconColor: AppColors.mainColor,
          childrenPadding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            ListView.builder(
              itemCount: gameModel.teams.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final team = gameModel.teams[index];
                return Row(
                  children: [
                    CustomText(
                      text: formattedTime,
                      color: AppColors.mainColor,
                    ),
                    CustomText(
                      text: team.name!,
                      color: AppColors.mainColor,
                    )
                  ],
                );
              },
            ),
            SizedBox(height: 8.h)
          ],
        ),
      ),
    );
  }
}
