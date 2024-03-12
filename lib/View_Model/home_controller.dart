import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt teamAPoints = 0.obs;
  RxInt teamBPoints = 0.obs;

  void incrementScore({required String team, required int number}) {
    if (team == 'A') {
      teamAPoints += number;
      update();
    } else {
      teamBPoints += number;
      update();
    }
  }

  void decrementScore({required String team, required int number}) {
    if (team == 'A') {
      teamAPoints += number;
      update();
    } else {
      teamBPoints += number;
      update();
    }
  }

  void resetScore({required String team}) {
    if (team == 'A') {
      teamAPoints.value = 0;
      update();
    } else {
      teamBPoints.value = 0;
      update();
    }
  }
}
