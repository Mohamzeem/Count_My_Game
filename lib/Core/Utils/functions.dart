import 'dart:io';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_button.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/Core/Widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppFunctions {
  AppFunctions._();

  static Future<dynamic> showBtmSheet(
      {required bool isDismissible,
      required BuildContext context,
      required List<Widget> body}) {
    return showModalBottomSheet(
      useSafeArea: true,
      barrierColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: isDismissible,
      elevation: 10,
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
              color: AppColors.mainBGColor,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.min,
                shrinkWrap: true,
                children: body,
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<dynamic> showBtmSheetWithTextAndButton({
    required BuildContext context,
    required TextEditingController controller,
    required String title,
    required String lable,
    required String buttonText,
    required IconData sheetIcon,
    required IconData prefixIcon,
    required void Function() onPressedbutton,
    required void Function() onTapSheetIcon,
    void Function()? suffixIconFunction,
    bool? obscureText,
    bool? suffixIconShow,
  }) async {
    AppFunctions.showBtmSheet(
      isDismissible: true,
      context: context,
      body: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: title,
              color: AppColors.mainColor,
            ),
            InkWell(
              onTap: onTapSheetIcon,
              child: Icon(
                sheetIcon,
                color: AppColors.mainColor,
                size: 30,
              ),
            )
          ],
        ),
        SizedBox(height: 10.h),
        CustomTextFormField(
          obscureText: obscureText!,
          suffixIconShow: suffixIconShow!,
          suffixIconFunction: suffixIconFunction,
          label: lable,
          maxLength: 50,
          controller: controller,
          keyBoard: TextInputType.emailAddress,
          prefixIcon: prefixIcon,
        ),
        SizedBox(height: 10.h),
        CustomButton(
          onPressed: onPressedbutton,
          text: buttonText,
          width: double.infinity,
          height: 45,
          threeRadius: 10,
          lastRadius: 10,
          backgroundColor: AppColors.mainColor,
          textColor: AppColors.secColor,
        ),
        SizedBox(height: Platform.isIOS ? 10.h : 0.h),
      ],
    );
  }
}
