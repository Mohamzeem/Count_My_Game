import 'package:flutter/material.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/Core/Widgets/custom_text.dart';

class CustomDissmissItem extends StatelessWidget {
  const CustomDissmissItem({
    super.key,
    required this.onDismissed,
    required this.child,
    this.raduis = 20,
    this.fontSize = 22,
    this.color = AppColors.kRed,
    this.text = 'Delete',
  });

  final Function(DismissDirection)? onDismissed;
  final Widget child;
  final double raduis;
  final double fontSize;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.startToEnd,
      onDismissed: onDismissed,
      background: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.all(raduis),
          child: Align(
            alignment: Alignment.centerLeft,
            child: CustomText(
              text: text,
              color: AppColors.kWhite,
              fontWeight: FontWeight.w600,
              fontSize: fontSize,
            ),
          ),
        ),
      ),
      child: child,
    );
  }
}
