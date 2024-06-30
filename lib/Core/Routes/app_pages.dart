import 'package:count_my_game/Core/Routes/app_routes.dart';
import 'package:count_my_game/View/Authentication/register_view.dart';
import 'package:count_my_game/View/Authentication/forgot_password_view.dart';
import 'package:count_my_game/View/Authentication/email_login_view.dart';
import 'package:count_my_game/View/Authentication/guest_login_view.dart';
import 'package:count_my_game/View/Friends/friends_view.dart';
import 'package:count_my_game/View/Game/create_game_view/create_game_view.dart';
import 'package:count_my_game/View/Game/game_view/game_view.dart';
import 'package:count_my_game/View/Game/previous_games_view/previous_games_view.dart';
import 'package:count_my_game/View/Home/home_view.dart';
import 'package:count_my_game/View/Profile/profile_view.dart';
import 'package:get/get_navigation/get_navigation.dart';

class AppPages {
  AppPages();

  static final List<GetPage> routes = [
    // GetPage(
    //   name: AppRoute.initial,
    //   page: () => const AuthPageView(),
    // ),
    GetPage(
      name: AppRoute.emailLogInView,
      page: () => const EmailLoginView(),
    ),
    GetPage(
      name: AppRoute.createdGameView,
      page: () => const CreateGameView(),
    ),
    GetPage(
      name: AppRoute.guestLogInView,
      page: () => const GuestLoginView(),
    ),
    GetPage(
      name: AppRoute.forgotPasswordView,
      page: () => const ForgotPasswordView(),
    ),
    GetPage(
      name: AppRoute.registrationView,
      page: () => const RegisterView(),
    ),
    GetPage(
      name: AppRoute.profileView,
      page: () => const ProfileView(),
    ),
    GetPage(
      name: AppRoute.historyGameView,
      page: () => const PreviousGamesView(),
    ),
    GetPage(
      name: AppRoute.contactsView,
      page: () => const FriendsView(),
    ),
    GetPage(
      name: AppRoute.homeView,
      page: () => const HomeView(),
    ),
    GetPage(
      name: AppRoute.gameView,
      page: () => const GameView(),
    ),
    // GetPage(
    //   name: AppRoute.resultView,
    //   page: () => const ResultBody(),
    // ),
    // GetPage(
    //   name: AppRoute.groupDetailsView,
    //   page: () {
    //     final GroupsRoomModel model = Get.arguments;
    //     return GroupDetailsView(
    //       groupsRoomModel: model,
    //     );
    //   },
    // ),
  ];
}
