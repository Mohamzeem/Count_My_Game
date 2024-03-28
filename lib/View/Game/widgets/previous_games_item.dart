import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/Models/game_model.dart';
import 'package:count_my_game/View/Game/widgets/teams_previous_games_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class PreviousGamesItem extends StatelessWidget {
  final GameModel gameModel;
  final Function(DismissDirection)? onDismissed;
  const PreviousGamesItem({
    super.key,
    required this.gameModel,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    DateTime inputTime =
        DateTime.fromMillisecondsSinceEpoch(int.parse(gameModel.createdAt!));
    String formattedTime = DateFormat('dd/MM/yyyy h:mm a').format(inputTime);
    bool winner =
        gameModel.getWinnerId() == FirebaseAuth.instance.currentUser!.uid;

    return gameModel.isEnded == true
        ? Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.startToEnd,
            onDismissed: onDismissed,
            background: Container(
              decoration: BoxDecoration(
                  color: AppColors.kRed,
                  borderRadius: BorderRadius.circular(20)),
              child: const Padding(
                padding: EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: 'Delete',
                    color: AppColors.kWhite,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Card(
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
                                height: 40.h,
                                'assets/images/winner.svg',
                                colorFilter: ColorFilter.mode(
                                    AppColors.kGold, BlendMode.srcIn),
                              )
                            : SvgPicture.asset(
                                height: 40.h,
                                'assets/images/loser.svg',
                                colorFilter: const ColorFilter.mode(
                                    AppColors.kRed, BlendMode.srcIn),
                              ),
                        SizedBox(width: 15.w),
                        CustomText(
                          text: winner ? 'Winner' : 'Loser',
                          color: AppColors.kBlack,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                        const Spacer(),
                        CustomText(
                          text: gameModel.name!,
                          color: AppColors.kBlack,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    subtitle: Align(
                      alignment: Alignment.centerRight,
                      child: CustomText(
                        text: formattedTime,
                        color: AppColors.secColor,
                        fontSize: 15,
                      ),
                    ),
                    iconColor: AppColors.mainColor,
                    collapsedIconColor: AppColors.kBlack,
                    childrenPadding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      ListView.builder(
                        itemCount: gameModel.teams!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final team = gameModel.teams![index];
                          return TeamsInPreviousGamesItem(
                              team: team, gameModel: gameModel);
                        },
                      ),
                      SizedBox(height: 8.h),
                    ],
                  ),
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
