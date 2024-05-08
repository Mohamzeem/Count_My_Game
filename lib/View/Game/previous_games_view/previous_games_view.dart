import 'package:count_my_game/Core/Routes/app_routes.dart';
import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/View/Game/previous_games_view/widgets/previous_games_body.dart';
import 'package:count_my_game/View_Model/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreviousGamesView extends StatefulWidget {
  const PreviousGamesView({super.key});

  @override
  State<PreviousGamesView> createState() => _PreviousGamesViewState();
}

class _PreviousGamesViewState extends State<PreviousGamesView> {
  final controller = Get.put(GameController());
  @override
  void initState() {
    super.initState();
    debugPrint('initState: 1');
    controller.getPreviousGames();
    controller.uploadOfflineGames();
    debugPrint('initState: 2');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: PreviousGamesBody(),
      ),
      //^ floating start btn
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: FloatingActionButton(
          elevation: 5,
          backgroundColor: AppColors.mainColor,
          onPressed: () => Get.toNamed(AppRoute.createdGameView),
          child: const Icon(
            Icons.play_arrow,
            color: AppColors.kWhite,
            size: 50,
          ),
        ),
      ),
    );
  }
}
