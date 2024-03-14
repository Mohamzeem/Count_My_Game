import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';

class GameTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String lable;
  final TextInputType keyBoard;
  final int maxLength;
  final Color filled;
  final double height;
  final double width;

  const GameTextField({
    super.key,
    this.controller,
    required this.keyBoard,
    this.maxLength = 6,
    this.filled = AppColors.kWhite,
    required this.height,
    required this.width,
    this.lable = '',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: width.w,
      child: TextFormField(
        controller: controller,
        inputFormatters: [
          LengthLimitingTextInputFormatter(maxLength),
        ],
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
              borderSide: BorderSide(width: 0.5, color: AppColors.kGrey200)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: AppColors.kGrey200)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: AppColors.mainColor)),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: AppColors.mainColor)),
          focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: AppColors.mainColor)),
        ),
      ),
    );
  }
}
