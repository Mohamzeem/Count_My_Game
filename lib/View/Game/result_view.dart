import 'package:count_my_game/Core/Routes/app_routes.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_button.dart';
import 'package:count_my_game/Core/Widgets/custom_cached_image.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/View_Model/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';

class ResultView extends StatefulWidget {
  const ResultView({super.key});

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  final GameController controller = Get.find<GameController>();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) => controller.updateEndedgame());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GetBuilder<GameController>(
        builder: (cont) {
          DateTime inputTime = DateTime.fromMillisecondsSinceEpoch(
              int.parse(cont.gameModel.createdAt!));
          String formattedTime =
              DateFormat('dd/MM/yyyy  h:mm a').format(inputTime);
          return ListView(
            children: [
              Screenshot(
                controller: controller.screenShotController,
                child: Column(
                  children: [
                    //^  winner name
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: cont.gameModel.getWinnerName(),
                            fontSize: 38,
                            fontWeight: FontWeight.w600,
                            textOverflow: TextOverflow.fade,
                            color: AppColors.kWhite,
                            softWrap: false,
                          ),
                          Image.asset(
                            'assets/images/winner.png',
                            scale: 8,
                            color: AppColors.kGold,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    //^ winner photo
                    Container(
                      width: double.infinity,
                      height: 200.h,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: CustomCachedImage(
                          shape: BoxShape.rectangle,
                          // photoUrl: cont.gameModel.teams![0].isPhoto,
                          photoUrl: cont.gameModel.getWinnerPhoto(),
                          height: 170,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    //^ winner cup
                    Image.asset(
                      width: double.infinity,
                      height: 300.h,
                      'assets/images/success.png',
                      fit: BoxFit.fill,
                      color: AppColors.kGold,
                    ),
                    SizedBox(height: 40.h),
                    //^ game time
                    CustomText(
                      text: formattedTime,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: AppColors.kWhite,
                    ),
                    SizedBox(height: 20.h)
                  ],
                ),
              ),
              //^ row of 2 btns
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //^ play again btn
                  CustomButton(
                    onPressed: () {
                      Get.offNamed(AppRoute.createdGameView);
                      cont.resetClearData();
                      // print('1 ${cont.gameModel.getWinnerId()}');
                      // controller.updateEndedgame();
                      // print('1 ${controller.gameModel.id}');
                      // print(
                      //     'b ${controller.maxScore <= controller.teamBPoints.value ? 'Winner' : 'Loser'}');
                      // print(
                      //     'a ${controller.maxScore <= controller.teamAPoints.value ? 'Winner' : 'Loser'}');
                      // controller.updateEndedgame();
                    },
                    text: 'Play Again',
                    width: 170,
                    height: 50,
                    backgroundColor: AppColors.mainColor,
                  ),
                  //^ close btn
                  CustomButton(
                    onPressed: () {
                      Get.offNamed(AppRoute.homeView);
                      cont.clearAllData();
                    },
                    text: 'Close',
                    width: 170,
                    height: 50,
                    backgroundColor: AppColors.kGrey100,
                    textColor: AppColors.kBlack,
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              //^ screenshot btn
              CustomButton(
                onPressed: () => controller.screenShot(),
                text: 'Screenshot',
                width: 170,
                height: 50,
                backgroundColor: AppColors.kGrey100,
                textColor: AppColors.kBlack,
              ),
            ],
          );
        },
      ),
    );
  }
}
