import 'package:count_my_game/Core/Utils/enums.dart';

class AppState {
  AppState._();

  static bool isOnline = true;

  void onlineMode() {
    if (isOnline == true) {
      AppMode.onlineMMode;
    } else {
      AppMode.offlineMode;
    }
  }
}
