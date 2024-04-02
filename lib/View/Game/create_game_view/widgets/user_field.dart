import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';

class UserField extends StatelessWidget {
  final String initValue;
  final double width;
  const UserField({
    super.key,
    required this.initValue,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: width,
      decoration: BoxDecoration(
          color: AppColors.kWhite, borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: CustomText(
          text: initValue,
          color: AppColors.mainColor,
          textOverflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
