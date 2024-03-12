import 'package:count_my_game/View/Authentication/widgets/login_body_as_guest.dart';
import 'package:flutter/material.dart';

class GuestLoginView extends StatelessWidget {
  const GuestLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginBodyAsGuest(),
    );
  }
}
