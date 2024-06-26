import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_button.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
              width: 200.h,
              height: 200.w,
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
          title: SizedBox(
              width: 200.w,
              height: 200.h,
              child: const Icon(Icons.account_circle_sharp)),
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
      barrierColor: AppColors.mainColor.withOpacity(0.1),
      context: context,
      builder: (context) => AlertDialog(
        elevation: 10,
        surfaceTintColor: backGroundColor ?? AppColors.kWhite,
        backgroundColor: backGroundColor ?? AppColors.kWhite,
        title: Center(
          child: CustomText(
            text: textBody,
            softWrap: true,
            color: AppColors.mainColor,
            fontSize: 22,
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                onPressed: onPressed,
                text: textButton1,
                width: 80,
                height: 40,
                fontSize: 16,
              ),
              CustomButton(
                onPressed: () => Get.back(),
                text: textButton2,
                width: 80,
                height: 40,
                fontSize: 16,
                backgroundColor: AppColors.kBlack,
              ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     InkWell(
          //       onTap: onPressed,
          //       child: Container(
          //         width: 60.w,
          //         height: 60.h,
          //         decoration: const BoxDecoration(
          //           shape: BoxShape.circle,
          //           color: AppColors.mainColor,
          //         ),
          //         child: Card(
          //             color: AppColors.mainColor,
          //             elevation: 5,
          //             surfaceTintColor: AppColors.kWhite,
          //             child: Padding(
          //               padding: const EdgeInsets.all(10),
          //               child: CustomText(
          //                 text: textButton1,
          //                 color: AppColors.kWhite,
          //                 fontSize: 18,
          //               ),
          //             )),
          //       ),
          //     ),
          //     InkWell(
          //       onTap: () => Navigator.pop(context),
          //       child: Container(
          //         width: 60.w,
          //         height: 60.h,
          //         decoration: const BoxDecoration(
          //           shape: BoxShape.circle,
          //           color: AppColors.kBlack,
          //         ),
          //         child: Card(
          //           color: AppColors.kBlack,
          //           elevation: 5,
          //           surfaceTintColor: AppColors.kWhite,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(100.0),
          //             side: const BorderSide(color: AppColors.kWhite),
          //           ),
          //           child: Padding(
          //             padding: const EdgeInsets.all(10),
          //             child: Center(
          //               child: CustomText(
          //                 text: textButton2,
          //                 color: AppColors.kWhite,
          //                 fontSize: 16,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     )
          //   ],
          // )
        ],
      ),
    );
  }
}
