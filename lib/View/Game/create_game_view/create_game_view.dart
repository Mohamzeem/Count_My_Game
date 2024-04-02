import 'package:count_my_game/View/Game/create_game_view/widgets/create_game_body.dart';
import 'package:flutter/material.dart';

class CreateGameView extends StatelessWidget {
  const CreateGameView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: CreateGameBody(),
      ),
    );
  }
}
