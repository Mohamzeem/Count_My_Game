import 'dart:convert';
import 'package:count_my_game/Core/Routes/app_routes.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_button.dart';
import 'package:count_my_game/Core/Widgets/custom_cached_image.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/View_Model/friends_controller.dart';
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
  final FriendsController friendsCont = Get.put(FriendsController());
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
                          Image.asset(
                            'assets/images/winner.png',
                            scale: 10,
                            color: AppColors.kGold,
                          ),
                          SizedBox(
                            width: 200.w,
                            child: CustomText(
                              textAlign: TextAlign.center,
                              text: cont.gameModel.getWinnerName(),
                              fontSize:
                                  cont.gameModel.getWinnerName().length > 10
                                      ? 28
                                      : 32,
                              fontWeight: FontWeight.w600,
                              textOverflow: TextOverflow.fade,
                              color: AppColors.kWhite,
                              softWrap: false,
                            ),
                          ),
                          Image.asset(
                            'assets/images/winner.png',
                            scale: 10,
                            color: AppColors.kGold,
                          ),
                        ],
                      ),
                    ),
                    20.verticalSpace,
                    //^ winner photo
                    cont.gameModel.getWinnerPhoto().contains('firebasestorage')
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CustomCachedImage(
                              isBorder: false,
                              shape: BoxShape.rectangle,
                              photoUrl: cont.gameModel.getWinnerPhoto(),
                              height: 170.h,
                              width: 250.w,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.rectangle,
                              ),
                              height: 170.h,
                              width: 250.w,
                              child: cont.gameModel.getWinnerPhoto().isEmpty
                                  ? CircularProgressIndicator(
                                      color: AppColors.kGold)
                                  : Image.memory(
                                      base64Decode(
                                          cont.gameModel.getWinnerPhoto()),
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                    SizedBox(height: 20.h),
                    //^ winner cup
                    Image.asset(
                      width: double.infinity,
                      height: 260.h,
                      'assets/images/success.png',
                      fit: BoxFit.fill,
                      color: AppColors.kGold,
                    ),
                    SizedBox(height: 20.h),
                    //^ game time & score
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CustomText(
                          text: formattedTime,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.kWhite,
                        ),
                        Wrap(
                          children: [
                            CustomText(
                              text: cont.gameModel.getWinnerScore(),
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: AppColors.kGold,
                            ),
                            CustomText(
                              text: '/${cont.gameModel.maxScore.toString()}',
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                              color: AppColors.kWhite,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h)
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
                    },
                    text: 'Play Again',
                    width: 150,
                    height: 35,
                    backgroundColor: AppColors.mainColor,
                  ),
                  //^ close btn
                  CustomButton(
                    onPressed: () {
                      Get.offNamed(AppRoute.homeView);
                      cont.clearAllData();
                    },
                    text: 'Close',
                    width: 150,
                    height: 35,
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
                height: 35,
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
