import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:count_my_game/Core/Routes/app_routes.dart';
import 'package:count_my_game/Core/Utils/app_strings.dart';
import 'package:count_my_game/Core/Widgets/custom_loading.dart';
import 'package:count_my_game/Models/game_model.dart';
import 'package:count_my_game/Models/team_model.dart';
import 'package:count_my_game/Models/user_model.dart';
import 'package:count_my_game/View/Game/result_view.dart';
import 'package:count_my_game/View/Game/widgets/game_body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:uuid/uuid.dart';

class GameController extends GetxController {
  final _checker = InternetConnectionChecker();
  final _fireStore = FirebaseFirestore.instance;
  final _fireStorage = FirebaseStorage.instance;
  final _auth = FirebaseAuth.instance;
  final _uuid = const Uuid();
  RxInt teamAPoints = 0.obs;
  RxInt teamBPoints = 0.obs;
  RxInt teamCPoints = 0.obs;
  RxInt teamDPoints = 0.obs;
  RxList scoreListATeam = [].obs;
  RxList scoreListBTeam = [].obs;
  RxList scoreListCTeam = [].obs;
  RxList scoreListDTeam = [].obs;
  final RxString selectedNum = ''.obs;
  final RxString selectedGame = ''.obs;
  final RxBool _gameCreated = false.obs;
  final teamOneController = TextEditingController();
  final teamTwoController = TextEditingController();
  final teamThreeController = TextEditingController();
  final teamFourController = TextEditingController();
  final maxScoreController = TextEditingController();
  final newScoreController = TextEditingController();
  final emailController = TextEditingController();

  List<String> numList = ['2', '3', '4'];
  List<String> gamesList = ['Dominos', 'Cards', 'Playstation', 'Other'];
  final String _createdAtTime =
      DateTime.now().millisecondsSinceEpoch.toString();

  bool get isCreated => _gameCreated.value;

  void dropDownValueGamesList(String val) => selectedGame.value = val;
  void dropDownValueNumList(String val) => selectedNum.value = val;

  String get teamOneName => teamOneController.text;
  set teamOneName(String val) {
    teamOneController.text = val;
    update();
  }

  String get teamTwoName => teamTwoController.text;
  set teamTwoName(String val) {
    teamTwoController.text = val;
    update();
  }

  String get teamThreeName => teamThreeController.text;
  set teamThreeName(String val) {
    teamThreeController.text = val;
    update();
  }

  String get teamFourName => teamFourController.text;
  set teamFourName(String val) {
    teamFourController.text = val;
    update();
  }

  String get searchEmail => emailController.text;
  set searchEmail(String val) {
    emailController.text = val;
    update();
  }

  int get maxScore => int.parse(maxScoreController.text);
  set maxScore(int val) {
    int.parse(maxScoreController.text);
    update();
  }

  int get newScore => int.parse(newScoreController.text);
  set newScore(int val) {
    int.parse(maxScoreController.text);
    update();
  }

  @override
  void dispose() {
    teamOneController.dispose();
    teamTwoController.dispose();
    teamThreeController.dispose();
    teamFourController.dispose();
    maxScoreController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _clearCons() {
    teamOneController.clear();
    teamTwoController.clear();
    teamThreeController.clear();
    teamFourController.clear();
    maxScoreController.clear();
  }

  set isCreated(bool val) {
    _gameCreated.value = val;
    update();
  }

  Future _createGame(String idTwo, String idThree, String idFour) async {
    CustomLoading.show();
    final teamOneId = _auth.currentUser!.uid;
    final randomGameId = _uuid.v1();

    TeamModel teamOne = TeamModel(id: teamOneId, name: teamOneName, photo: "");
    TeamModel teamTwo = TeamModel(id: idTwo, name: teamTwoName, photo: "");
    TeamModel teamThree =
        TeamModel(id: idThree, name: teamThreeName, photo: "");
    TeamModel teamFour = TeamModel(id: idFour, name: teamFourName, photo: "");

    final List<String> members = selectedNum.value == '3'
        ? [teamOne.id!, teamTwo.id!, teamThree.id!]
        : selectedNum.value == '4'
            ? [teamOne.id!, teamTwo.id!, teamThree.id!, teamFour.id!]
            : [teamOne.id!, teamTwo.id!]
      ..sort((a, b) => b.compareTo(a));

    GameModel gameModel = GameModel(
      id: randomGameId,
      name: selectedGame.value,
      members: members,
      createdAt: _createdAtTime,
      maxScore: maxScore,
      teams: selectedNum.value == '3'
          ? [teamOne, teamTwo, teamThree]
          : selectedNum.value == '4'
              ? [teamOne, teamTwo, teamThree, teamFour]
              : [teamOne, teamTwo],
    );
    await _fireStore
        .collection(AppStrings.gamesCollection)
        .doc(randomGameId)
        .set(gameModel.toMap())
        .whenComplete(() {
      CustomLoading.dismiss();
      Get.toNamed(AppRoute.gameView);
      _clearCons();
    });
  }

  void createGameFunction(
      {required String idTwo,
      required String idThree,
      required String idFour}) {
    if (selectedGame.isEmpty) {
      CustomLoading.toast(text: 'Selete Game');
    } else if (maxScoreController.text.isEmpty) {
      CustomLoading.toast(text: 'Max Score Required');
    } else {
      _createGame(idTwo, idThree, idFour);
      _clearCons();
    }
  }

  Stream<List<GameModel>> getPreviousGames() {
    final result = FirebaseFirestore.instance
        .collection(AppStrings.gamesCollection)
        .snapshots();
    return result.map((snapshot) {
      // Map each document snapshot into a GameModel object
      return snapshot.docs.map((doc) {
        return GameModel.fromMap(doc.data());
      }).toList();
    });
  }

  Stream<List<UserModel>> getUsers() {
    return _fireStore
        .collection(AppStrings.usersCollection)
        // .where('members', arrayContains: _auth.currentUser!.uid)
        .snapshots()
        .map((event) => event.docs.map(
              (e) {
                final data = e.data();
                return UserModel.fromJson(data);
              },
            ).toList());
  }

  void createNewGameFunction() {
    if (selectedNum.value == '') {
      CustomLoading.toast(text: 'Select a team number');
      return;
    }
    isCreated = !isCreated;
    isCreated ? selectedNum.value : selectedNum.value = '';
  }

  void _clearLists() {
    scoreListATeam.clear();
    scoreListBTeam.clear();
    scoreListCTeam.clear();
    scoreListDTeam.clear();
  }

  void gameEnded() {
    if (teamAPoints.value == maxScore ||
        teamBPoints.value == maxScore ||
        teamCPoints.value == maxScore ||
        teamDPoints.value == maxScore) {
      const ResultBody();
    } else {
      GameBody();
    }
  }

  void incrementScore({required String team}) {
    if (newScoreController.text.isNotEmpty) {
      if (team == 'A') {
        teamAPoints += newScore;
        scoreListATeam.add(newScore);
        newScoreController.clear();
        update();
      } else if (team == 'B') {
        teamBPoints += newScore;
        scoreListBTeam.add(newScore);
        newScoreController.clear();
        update();
      } else if (team == 'C') {
        teamCPoints += newScore;
        scoreListCTeam.add(newScore);
        newScoreController.clear();
        update();
      } else if (team == 'D') {
        teamDPoints += newScore;
        scoreListDTeam.add(newScore);
        newScoreController.clear();
        update();
      }
    }
  }

  void undoScore({required String team}) {
    if (team == 'A') {
      if (scoreListATeam.isNotEmpty) {
        int lastAdded = scoreListATeam.removeLast();
        teamAPoints -= lastAdded;
        _clearLists();
        update();
      }
    } else if (team == 'B') {
      if (scoreListBTeam.isNotEmpty) {
        int lastAdded = scoreListBTeam.removeLast();
        teamBPoints -= lastAdded;
        _clearLists();
        update();
      }
    } else if (team == 'C') {
      if (scoreListCTeam.isNotEmpty) {
        int lastAdded = scoreListCTeam.removeLast();
        teamCPoints -= lastAdded;
        _clearLists();
        update();
      }
    } else if (team == 'D') {
      if (scoreListDTeam.isNotEmpty) {
        int lastAdded = scoreListDTeam.removeLast();
        teamDPoints -= lastAdded;
        _clearLists();
        update();
      }
    }
  }

  Future setProfileImage() async {
    ImagePicker imagePicker = ImagePicker();
    bool isConnected = await _checkInternet();
    if (isConnected) {
      final image = await imagePicker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        _uploadImage(
          file: File(image.path),
          userId: FirebaseAuth.instance.currentUser!.uid,
        );
      }
    }
  }

  Future _uploadImage({
    required File file,
    required String userId,
  }) async {
    CustomLoading.show();
    final String imagePath = file.path.split('.').last;
    final ref = _fireStorage
        .ref('TeamsImages')
        .child('$userId/${DateTime.now().millisecondsSinceEpoch}.$imagePath');

    await ref.putFile(file);
    final String imageUrl = await ref.getDownloadURL();

    await _auth.currentUser!.updatePhotoURL(imageUrl);
    await _fireStore
        .collection(AppStrings.usersCollection)
        .doc(userId)
        .update({'teamPhotos': imageUrl});
    CustomLoading.toast(
        text: 'Image changed successfully',
        toastPosition: EasyLoadingToastPosition.bottom);
  }

  Future<bool> _checkInternet() async {
    if (await _checker.hasConnection) {
      return true;
    } else {
      return false;
    }
  }
}
