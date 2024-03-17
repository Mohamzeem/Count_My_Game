import 'package:count_my_game/Core/Utils/app_colors.dart';
import 'package:count_my_game/View/Contacts/contacts_view.dart';
import 'package:count_my_game/View/Game/history_game_view.dart';
import 'package:count_my_game/View/Profile/profile_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final auth = FirebaseAuth.instance;
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
        widget = const ContactsView();
        break;
      case 1:
        widget = const HistoryGameView();
        break;
      case 2:
        widget = const ProfileView();
        break;

      default:
        widget = const HistoryGameView();
        break;
    }
    return widget;
  }
}
