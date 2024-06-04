import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_dismiss_item.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/Models/game_model.dart';
import 'package:count_my_game/View/Game/previous_games_view/widgets/previous_games_teams.dart';
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
        ? CustomDissmissItem(
            onDismissed: onDismissed,
            child: Card(
              surfaceTintColor: Colors.transparent,
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.kBackGround,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ExpansionTile(
                  leading: winner
                      ? SvgPicture.asset(
                          height: 35.h,
                          'assets/images/winner.svg',
                          colorFilter: ColorFilter.mode(
                            AppColors.kGold,
                            BlendMode.srcIn,
                          ),
                        )
                      : SvgPicture.asset(
                          height: 35.h,
                          'assets/images/loser.svg',
                          colorFilter: const ColorFilter.mode(
                            AppColors.kRed,
                            BlendMode.srcIn,
                          ),
                        ),
                  title: Row(
                    children: [
                      CustomText(
                        text: winner ? 'Winner' : 'Loser',
                        color: winner ? AppColors.kGold : AppColors.kRed,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      const Spacer(),
                      CustomText(
                        text: gameModel.name!,
                        color: AppColors.kBlack,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  subtitle: Align(
                    alignment: Alignment.centerRight,
                    child: CustomText(
                      text: formattedTime,
                      color: AppColors.secColor,
                      fontSize: 14,
                    ),
                  ),
                  iconColor: AppColors.mainColor,
                  collapsedIconColor: AppColors.kBlack,
                  childrenPadding: EdgeInsets.symmetric(horizontal: 20.w),
                  children: [
                    ListView.builder(
                      itemCount: gameModel.teams!.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final team = gameModel.teams![index];
                        return TeamsInPreviousGamesItem(
                          team: team,
                          gameModel: gameModel,
                        );
                      },
                    ),
                    SizedBox(height: 8.h),
                  ],
                ),
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
