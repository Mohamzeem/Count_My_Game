import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double width;
  final double height;
  final double? threeRadius;
  final double? lastRadius;
  final double? fontSize;
  final Color? backgroundColor;
  final Color? textColor;
  final TextAlign? textAlign;
  final double? loadingWidth;
  final double? loadingHeight;
  final FontWeight? fontWeight;
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.width,
    required this.height,
    this.lastRadius,
    this.threeRadius,
    this.fontSize = 20,
    this.backgroundColor,
    this.textColor,
    this.textAlign,
    this.loadingWidth = 25,
    this.loadingHeight = 25,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
      width: width.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          backgroundColor: backgroundColor ?? AppColors.mainColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(threeRadius ?? 10),
              topRight: Radius.circular(threeRadius ?? 10),
              bottomRight: Radius.circular(threeRadius ?? 10),
              bottomLeft: Radius.circular(lastRadius ?? 10),
            ),
          ),
        ),
        onPressed: onPressed,
        child: CustomText(
          fontSize: fontSize,
          text: text,
          color: textColor ?? AppColors.kWhite,
          textAlign: textAlign,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}
