import 'package:count_my_game/Core/App/app_info.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextDecoration? textDecoration;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool? softWrap;
  const CustomText({
    super.key,
    required this.text,
    this.fontSize = 20,
    this.color,
    this.textDecoration,
    this.textOverflow,
    this.textAlign,
    this.maxLines,
    this.fontWeight,
    this.softWrap,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? AppColors.kBlack,
        decoration: textDecoration,
        fontSize: fontSize!.sp,
        fontWeight: fontWeight,
        fontFamily: MyApp.appFont,
      ),
      overflow: textOverflow,
      textAlign: textAlign,
      maxLines: maxLines,
      softWrap: softWrap,
    );
  }
}
