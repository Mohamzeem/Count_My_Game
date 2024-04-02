import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/View/Friends/friends_view.dart';
import 'package:count_my_game/View/Game/previous_games_view/previous_games_view.dart';
import 'package:count_my_game/View/Profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  int _index = 1;

  int get index => _index;
  set index(int value) {
    _index = value;
    update();
  }

  List<Widget> icons = [
    const Icon(
      Icons.group,
      color: AppColors.kWhite,
      size: 35,
    ),
    const Icon(
      Icons.history,
      color: AppColors.kWhite,
      size: 35,
    ),
    const Icon(
      Icons.settings,
      color: AppColors.kWhite,
      size: 35,
    ),
  ];

  Widget getSelectedWidget() {
    Widget widget;
    switch (index) {
      case 0:
        widget = const FriendsView();
        break;
      case 1:
        widget = const PreviousGamesView();
        break;
      case 2:
        widget = const ProfileView();
        break;

      default:
        widget = const PreviousGamesView();
        break;
    }
    return widget;
  }
}
