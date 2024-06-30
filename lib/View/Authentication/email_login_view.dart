import 'package:count_my_game/View/Authentication/widgets/login_body_with_email.dart';
import 'package:flutter/material.dart';

class EmailLoginView extends StatelessWidget {
  const EmailLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginBodyWithEmail(),
    );
  }
}
