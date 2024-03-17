import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_circular_loading.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/Models/game_model.dart';
import 'package:count_my_game/View_Model/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              child: ListView.builder(
                itemCount: gameList.length,
                itemBuilder: (context, index) {
                  final gameModel = gameList[index];
                  DateTime inputTime = DateTime.fromMillisecondsSinceEpoch(
                      int.parse(gameModel.createdAt!));
                  String formattedTime = DateFormat('h:mm a').format(inputTime);
                  return Container(
                    height: 50,
                    width: 300,
                    color: AppColors.kWhite,
                  );
                  // return Row(
                  //   children: [
                  //     // CustomText(
                  //     //   text: gameModel.id!,
                  //     //   color: AppColors.mainColor,
                  //     // ),
                  //     // CustomText(
                  //     //   text: formattedTime,
                  //     //   color: AppColors.mainColor,
                  //     // ),
                  //     CustomText(
                  //       text: gameModel.name!,
                  //       color: AppColors.mainColor,
                  //     )
                  //   ],
                  // );
                },
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
