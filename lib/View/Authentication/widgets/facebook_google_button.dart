import 'package:count_my_game/Core/Widgets/custom_text_button.dart';
import 'package:flutter/material.dart';

class LoginGoogleFacebook extends StatelessWidget {
  final String logo;
  final String title;
  final bool? isLoading;
  final void Function() onPressed;
  const LoginGoogleFacebook({
    super.key,
    required this.logo,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
//~logo
        Image.asset(
          'assets/images/$logo.png',
          scale: 3.5,
        ),
//~title
        CustomTextButton(
          text: isLoading! ? 'loading ...' : 'Login with $title',
          onPressed: onPressed,
          underline:
              isLoading! ? TextDecoration.none : TextDecoration.underline,
        ),
      ],
    );
  }
}
