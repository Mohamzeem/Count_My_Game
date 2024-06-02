import 'package:count_my_game/Core/Utils/enums.dart';

class AppState {
  AppState._();

  static String isOnline = '';

  void onlineMode() {
    if (isOnline == AppState.isOnline) {
      AppMode.onlineMMode;
    } else {
      AppMode.offlineMode;
    }
  }
}
