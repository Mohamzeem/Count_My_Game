import 'package:count_my_game/Core/Widgets/custom_text.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final TextDecoration? underline;
  final double? fontSize;
  final Color? color;
  const CustomTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.underline = TextDecoration.underline,
    this.fontSize = 24,
    this.color = AppColors.mainColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: CustomText(
        text: text,
        fontSize: fontSize,
        textDecoration: underline,
        color: color,
      ),
    );
  }
}
