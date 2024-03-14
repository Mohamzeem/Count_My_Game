import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:count_my_game/View_Model/home_controller.dart';
import 'package:get/instance_manager.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
