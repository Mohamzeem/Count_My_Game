// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final IconData prefixIcon;
  final VoidCallback? suffixIconFunction;
  final bool suffixIconShow;
  final bool obscureText;
  final TextInputType keyBoard;
  final int maxLength;
  final Color filled;
  const CustomTextFormField({
    super.key,
    this.controller,
    required this.label,
    required this.prefixIcon,
    this.suffixIconFunction,
    this.suffixIconShow = false,
    this.obscureText = false,
    required this.keyBoard,
    this.maxLength = 50,
    this.filled = AppColors.kWhite,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 40.h,
      // width: double.infinity,
      child: TextFormField(
        controller: controller,
        keyboardType: keyBoard,
        inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
        cursorColor: AppColors.mainColor,
        textInputAction: TextInputAction.done,
        obscureText: obscureText,
        maxLines: 1,
        style: TextStyle(
          fontSize: 20.sp,
          color: AppColors.mainColor,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          prefixIcon: Icon(
            prefixIcon,
            color: AppColors.mainColor,
          ),
          suffixIcon: suffixIconShow
              ? InkWell(
                  onTap: suffixIconFunction,
                  child: obscureText
                      ? const Icon(
                          Icons.visibility_off,
                          color: AppColors.mainColor,
                        )
                      : const Icon(
                          Icons.visibility,
                          color: AppColors.mainColor,
                        ))
              : const SizedBox(),
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
          fillColor: filled,
          filled: true,
          label: CustomText(
            text: label,
            color: AppColors.mainColor,
            fontSize: 20,
          ),
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
