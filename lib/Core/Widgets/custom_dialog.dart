import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_button.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDialog {
  static Future<void> oneDialog({
    required BuildContext context,
    required String textBody,
    required void Function() onPressed,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.kWhite,
          title: InkWell(
            onTap: onPressed,
            child: SizedBox(
              width: 200,
              height: 200,
              child: CustomText(
                text: textBody,
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> oneButtonDialog({
    required BuildContext context,
    required String textBody,
    required String textButton,
    required void Function() onPressed,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.kWhite,
          title: const SizedBox(
              width: 200, height: 200, child: Icon(Icons.account_circle_sharp)),
          content: CustomText(
            text: textBody,
          ),
          actions: [
            CustomButton(
              onPressed: onPressed,
              text: textButton,
              width: 320,
              height: 45,
              lastRadius: 10,
              threeRadius: 10,
            )
          ],
        );
      },
    );
  }

  static Future<void> twoButtonDialog({
    required BuildContext context,
    required String textBody,
    Color? backGroundColor,
    required String textButton1,
    required String textButton2,
    required void Function() onPressed,
  }) async {
    showDialog(
      barrierDismissible: true,
      barrierColor: AppColors.mainColor.withOpacity(0.4),
      context: context,
      builder: (context) => AlertDialog(
        elevation: 10,
        surfaceTintColor: backGroundColor ?? AppColors.secColor,
        backgroundColor: backGroundColor ?? AppColors.secColor,
        title: Center(
          child: CustomText(
            text: textBody,
            softWrap: true,
            fontSize: 22,
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: onPressed,
                child: Container(
                  width: 55.w,
                  height: 55.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.mainColor,
                  ),
                  child: Card(
                      color: AppColors.mainColor,
                      elevation: 5,
                      surfaceTintColor: AppColors.kWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                        side: BorderSide(color: AppColors.secColor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: CustomText(
                          text: textButton1,
                          color: AppColors.kWhite,
                          fontSize: 18,
                        ),
                      )),
                ),
              ),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 55.w,
                  height: 55.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.kBlack,
                  ),
                  child: Card(
                    color: AppColors.kBlack,
                    elevation: 5,
                    surfaceTintColor: AppColors.kWhite,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                      side: BorderSide(color: AppColors.secColor),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: CustomText(
                          text: textButton2,
                          color: AppColors.kWhite,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
