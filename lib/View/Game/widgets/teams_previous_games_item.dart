import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/Models/game_model.dart';
import 'package:count_my_game/Models/team_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TeamsInPreviousGamesItem extends StatelessWidget {
  const TeamsInPreviousGamesItem({
    super.key,
    required this.team,
    required this.gameModel,
  });

  final TeamModel team;
  final GameModel gameModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 180.w,
              child: CustomText(
                text: team.name!,
                color: AppColors.mainColor,
                // fontWeight: FontWeight.w600,
                textOverflow: TextOverflow.fade,
                softWrap: false,
              ),
            ),
            CustomText(
              text: '${team.score!}/${gameModel.maxScore}',
              color: AppColors.mainColor,
              // fontWeight: FontWeight.w600,
            ),
            team.isWinner == true
                ? SvgPicture.asset(
                    height: 25.h,
                    'assets/images/winner.svg',
                    colorFilter:
                        ColorFilter.mode(AppColors.kGold, BlendMode.srcIn),
                  )
                : SvgPicture.asset(
                    height: 25.h,
                    'assets/images/loser.svg',
                    colorFilter:
                        const ColorFilter.mode(AppColors.kRed, BlendMode.srcIn),
                  ),
          ],
        ),
        Divider(
          height: 5.h,
          thickness: 0.5,
          color: AppColors.mainColor,
        ),
      ],
    );
  }
}
