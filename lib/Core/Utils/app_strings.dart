import 'package:count_my_game/Core/Utils/enums.dart';

class AppStrings {
  AppStrings._();

//~ Globals
  static String fontFamily = 'MouseMemoirs';
  static const String defaultEmail = '@gmail.com';
  static String? userId = '';
  static String? userPhoto = '';
  static String? userName = '';
  static String? role = '';
  static const String defaultAppPhoto =
      "https://firebasestorage.googleapis.com/v0/b/chat-app-df0f1.appspot.com/o/account.png?alt=media&token=fd6675d2-ead9-4f50-9e14-4fddbb4ce864";
  static const String noImage =
      'https://firebasestorage.googleapis.com/v0/b/chat-app-df0f1.appspot.com/o/blank.jpg?alt=media&token=b51191d0-8528-44b4-af9f-af10379a0069';

  //~ Firebase Collections
  static const String chatCollection = 'Chat';
  static const String groupsCollection = 'Groups';
  static const String usersCollection = 'Users';
  static const String gamesCollection = 'Games';
  static String notificationsCollection = 'Notifications';

  // //~ is game online?
  // static const AppMode onlineGame = AppMode.onlineMMode;
  // static const AppMode offlineGame = AppMode.offlineMode;
}
