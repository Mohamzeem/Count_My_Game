// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';

class GameTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String lable;
  final TextInputType keyBoard;
  final int maxLength;
  final Color filled;
  final double height;
  final double width;
  final bool isRead;

  const GameTextField({
    super.key,
    this.controller,
    this.lable = '',
    required this.keyBoard,
    this.maxLength = 6,
    this.filled = AppColors.kWhite,
    required this.height,
    required this.width,
    this.isRead = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: width.w,
      child: TextFormField(
        readOnly: isRead,
        controller: controller,
        inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
        keyboardType: keyBoard,
        cursorColor: AppColors.mainColor,
        textInputAction: TextInputAction.done,
        maxLines: 1,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 20,
            color: AppColors.mainColor,
            fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          label: Center(
            child: CustomText(
              text: lable,
              fontSize: 16,
              color: AppColors.mainColor,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
          fillColor: filled,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0.5, color: AppColors.kGrey200)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(width: 0.5, color: AppColors.kGrey200)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
                  const BorderSide(width: 0.5, color: AppColors.mainColor)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
                  const BorderSide(width: 0.5, color: AppColors.mainColor)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide:
                  const BorderSide(width: 0.5, color: AppColors.mainColor)),
        ),
      ),
    );
  }
}
