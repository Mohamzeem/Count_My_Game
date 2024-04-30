import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:count_my_game/Core/Routes/app_routes.dart';
import 'package:count_my_game/Core/Utils/app_strings.dart';
import 'package:count_my_game/Core/Utils/functions.dart';
import 'package:count_my_game/Core/Widgets/custom_loading.dart';
import 'package:count_my_game/Models/game_model.dart';
import 'package:count_my_game/Models/team_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:uuid/uuid.dart';

class GameController extends GetxController {
  // final _checker = InternetConnectionChecker();
  final _fireStore = FirebaseFirestore.instance;
  // final _fireStorage = FirebaseStorage.instance;
  final _auth = FirebaseAuth.instance;
  final _uuid = const Uuid();
  final ImagePicker _imagePicker = ImagePicker();
  RxInt teamAPoints = 0.obs;
  RxInt teamBPoints = 0.obs;
  RxInt teamCPoints = 0.obs;
  RxInt teamDPoints = 0.obs;
  RxList scoreListATeam = [].obs;
  RxList scoreListBTeam = [].obs;
  RxList scoreListCTeam = [].obs;
  RxList scoreListDTeam = [].obs;
  RxList userTeamPhotos = [].obs;
  RxString selectedNum = ''.obs;
  RxString selectedGame = ''.obs;
  RxBool _gameCreated = false.obs;
  // final bool _fromFriends = false;
  final maxScoreController = TextEditingController();
  final newScoreController = TextEditingController();
  final emailController = TextEditingController();
  final screenShotController = ScreenshotController();

  List<String> numList = ['2', '3', '4'];
  List<String> gamesList = ['Dominos', 'Cards', 'Playstation', 'Other'];
  final String _createdAtTime =
      DateTime.now().millisecondsSinceEpoch.toString();

  void dropDownValueGamesList(String val) => selectedGame.value = val;
  void dropDownValueNumList(String val) => selectedNum.value = val;

  bool get isCreated => _gameCreated.value;
  set isCreated(bool val) {
    _gameCreated.value = val;
    update();
  }

  final Rx<GameModel> _gameModel = const GameModel().obs;
  GameModel get gameModel => _gameModel.value;
  set gameModel(GameModel model) {
    _gameModel.value = model;
    update();
  }

  final Rx<TeamModel> _teamOneModel = const TeamModel().obs;
  final Rx<TeamModel> _teamTwoModel = const TeamModel().obs;
  final Rx<TeamModel> _teamThreeModel = const TeamModel().obs;
  final Rx<TeamModel> _teamFourModel = const TeamModel().obs;
  TeamModel get teamOne => _teamOneModel.value;
  set teamOne(TeamModel model) {
    _teamOneModel.value = model;
    update();
  }

  TeamModel get teamTwo => _teamTwoModel.value;
  set teamTwo(TeamModel model) {
    _teamTwoModel.value = model;
    update();
  }

  TeamModel get teamThree => _teamThreeModel.value;
  set teamThree(TeamModel model) {
    _teamThreeModel.value = model;
    update();
  }

  TeamModel get teamFour => _teamFourModel.value;
  set teamFour(TeamModel model) {
    _teamFourModel.value = model;
    update();
  }

  final RxString _pickedTeamTwoImage = ''.obs;
  final RxString _pickedTeamThreeImage = ''.obs;
  final RxString _pickedTeamFourImage = ''.obs;
  String get pickedTeamTwoImage => _pickedTeamTwoImage.value;
  set pickedTeamTwoImage(String val) {
    _pickedTeamTwoImage.value = val;
    update();
  }

  String get pickedTeamThreeImage => _pickedTeamThreeImage.value;
  set pickedTeamThreeImage(String val) {
    _pickedTeamThreeImage.value = val;
    update();
  }

  String get pickedTeamFourImage => _pickedTeamFourImage.value;
  set pickedTeamFourImage(String val) {
    _pickedTeamFourImage.value = val;
    update();
  }

  final teamTwoNameController = TextEditingController();
  final teamThreeNameController = TextEditingController();
  final teamFourNameController = TextEditingController();
  String get teamTwoName => teamTwoNameController.text.trim();
  set teamTwoName(String val) {
    teamTwoNameController.text = val;
    update();
  }

  String get teamThreeName => teamThreeNameController.text;
  set teamThreeName(String val) {
    teamThreeNameController.text = val;
    update();
  }

  String get teamFourName => teamFourNameController.text;
  set teamFourName(String val) {
    teamFourNameController.text = val;
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
    teamTwoNameController.dispose();
    teamThreeNameController.dispose();
    teamFourNameController.dispose();
    maxScoreController.dispose();
    newScoreController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void clearAllData() {
    teamTwoNameController.clear();
    teamThreeNameController.clear();
    teamFourNameController.clear();
    newScoreController.clear();
    maxScoreController.clear();
    emailController.clear();
    teamAPoints = 0.obs;
    teamBPoints = 0.obs;
    teamCPoints = 0.obs;
    teamDPoints = 0.obs;
    scoreListATeam = [].obs;
    scoreListBTeam = [].obs;
    scoreListCTeam = [].obs;
    scoreListDTeam = [].obs;
    selectedNum = ''.obs;
    _gameCreated = false.obs;
    selectedGame = ''.obs;
  }

  void resetClearData() {
    newScoreController.clear();
    teamAPoints = 0.obs;
    teamBPoints = 0.obs;
    teamCPoints = 0.obs;
    teamDPoints = 0.obs;
    scoreListATeam = [].obs;
    scoreListBTeam = [].obs;
    scoreListCTeam = [].obs;
    scoreListDTeam = [].obs;
  }

  Future _createGameOfflineMode() async {
    CustomLoading.show();

    final randomGameId = _uuid.v1();
    final randomTeamTwoId = _uuid.v4();
    final randomTeamThreeId = _uuid.v4();
    final randomTeamFourId = _uuid.v4();

    final teamOne = TeamModel(
        id: _auth.currentUser!.uid,
        name: _auth.currentUser!.displayName,
        photo: _auth.currentUser!.photoURL);
    final teamTwo =
        TeamModel(id: randomTeamTwoId, name: teamTwoName, photo: '');
    final teamThree =
        TeamModel(id: randomTeamThreeId, name: teamThreeName, photo: "");
    final teamFour =
        TeamModel(id: randomTeamFourId, name: teamFourName, photo: "");

    final List<String> members = selectedNum.value == '3'
        ? [teamOne.id!, teamTwo.id!, teamThree.id!]
        : selectedNum.value == '4'
            ? [teamOne.id!, teamTwo.id!, teamThree.id!, teamFour.id!]
            : [teamOne.id!, teamTwo.id!]
      ..sort((a, b) => b.compareTo(a));

    gameModel = GameModel(
      id: randomGameId,
      name: selectedGame.value,
      members: members,
      createdAt: _createdAtTime,
      maxScore: maxScore,
      teams: selectedNum.value == '2'
          ? [teamOne, teamTwo]
          : selectedNum.value == '3'
              ? [teamOne, teamTwo, teamThree]
              : [teamOne, teamTwo, teamThree, teamFour],
    );
    await _fireStore
        .collection(AppStrings.gamesCollection)
        .doc(randomGameId)
        .set(gameModel.toMap())
        .whenComplete(() {
      CustomLoading.dismiss();
      Get.offNamed(AppRoute.gameView);
    });
  }

  // Future _createGameOnlineMode(
  //     String twoName,
  //     String threeName,
  //     String fourName,
  //     String twoPhoto,
  //     String threePhoto,
  //     String fourPhoto) async {
  //   CustomLoading.show();
  //   final randomGameId = _uuid.v1();
  //   final randomTeamTwoId = _uuid.v4();
  //   final randomTeamThreeId = _uuid.v4();
  //   final randomTeamFourId = _uuid.v4();
  //   final teamOne = TeamModel(
  //       id: _auth.currentUser!.uid,
  //       name: _auth.currentUser!.displayName,
  //       photo: _auth.currentUser!.photoURL);
  //   final teamTwo =
  //       TeamModel(id: randomTeamTwoId, name: twoName, photo: twoPhoto);
  //   final teamThree =
  //       TeamModel(id: randomTeamThreeId, name: threeName, photo: threePhoto);
  //   final teamFour =
  //       TeamModel(id: randomTeamFourId, name: fourName, photo: fourPhoto);
  //   final List<String> members = selectedNum.value == '3'
  //       ? [teamOne.id!, teamTwo.id!, teamThree.id!]
  //       : selectedNum.value == '4'
  //           ? [teamOne.id!, teamTwo.id!, teamThree.id!, teamFour.id!]
  //           : [teamOne.id!, teamTwo.id!]
  //     ..sort((a, b) => b.compareTo(a));
  //   gameModel = GameModel(
  //     id: randomGameId,
  //     name: selectedGame.value,
  //     members: members,
  //     createdAt: _createdAtTime,
  //     maxScore: maxScore,
  //     teams: selectedNum.value == '2'
  //         ? [teamOne, teamTwo]
  //         : selectedNum.value == '3'
  //             ? [teamOne, teamTwo, teamThree]
  //             : [teamOne, teamTwo, teamThree, teamFour],
  //   );
  //   await _fireStore
  //       .collection(AppStrings.gamesCollection)
  //       .doc(randomGameId)
  //       .set(gameModel.toMap())
  //       .whenComplete(() {
  //     CustomLoading.dismiss();
  //     Get.offNamed(AppRoute.gameView);
  //   });
  // }

  void onlineFunctions(
      {required String twoName,
      required String twoPhoto,
      required String twoId}) {
    if (pickedTeamTwoImage == '' && teamTwo.photo! == '') {
      CustomLoading.toast(text: 'image Required');
    } else if (teamTwo.name == '' && teamTwoNameController.text.isEmpty) {
      CustomLoading.toast(text: 'Name Required');
    } else {
      // if (selectedNum.value == '2') {
      //   createTwoTeamsGameOnlineMode(
      //       twoName: twoName, twoPhoto: twoPhoto, twoId: twoId);
      // } else if (selectedNum.value == '3') {
      // } else {}
    }
  }

  Future createTwoTeamsGameOnlineMode(
      {required String twoName,
      required String twoPhoto,
      required String twoId}) async {
    if (pickedTeamTwoImage == '' && teamTwo.photo! == '') {
      CustomLoading.toast(text: 'image Required');
    } else if (teamTwo.name == '' && teamTwoNameController.text.isEmpty) {
      CustomLoading.toast(text: 'Name Required');
    } else {
      CustomLoading.show();
      final randomGameId = _uuid.v1();
      final randomTeamTwoId = _uuid.v4();
      final teamOne = TeamModel(
          id: _auth.currentUser!.uid,
          name: _auth.currentUser!.displayName,
          photo: _auth.currentUser!.photoURL);
      final teamTwo = TeamModel(
        id: twoId.isEmpty ? randomTeamTwoId : twoId,
        name: twoName.isEmpty ? teamTwoName : twoName,
        photo: twoPhoto,
      );
      final List<String> members = [teamOne.id!, teamTwo.id!]
        ..sort((a, b) => b.compareTo(a));

      gameModel = GameModel(
          id: randomGameId,
          name: selectedGame.value,
          members: members,
          createdAt: _createdAtTime,
          maxScore: maxScore,
          teams: [teamOne, teamTwo]);
      await _fireStore
          .collection(AppStrings.gamesCollection)
          .doc(randomGameId)
          .set(gameModel.toMap())
          .whenComplete(() {
        CustomLoading.dismiss();
        Get.offNamed(AppRoute.gameView);
      });
    }
  }

  Future createGameThreeTeamsOnlineMode({
    required String twoId,
    required String twoName,
    required String threeId,
    required String threeName,
    required String twoPhoto,
    required String threePhoto,
  }) async {
    if (pickedTeamTwoImage == '' && teamTwo.photo! == '') {
      CustomLoading.toast(text: 'Team Two image Required');
    } else if (pickedTeamThreeImage == '' && teamThree.photo! == '') {
      CustomLoading.toast(text: 'Team Three image Required');
    } else if (teamTwo.name == '' && teamTwoNameController.text.isEmpty) {
      CustomLoading.toast(text: 'Team Two Name Required');
    } else if (teamThree.name == '' && teamThreeNameController.text.isEmpty) {
      CustomLoading.toast(text: 'Team Three Name Required');
    } else {
      CustomLoading.show();
      final randomGameId = _uuid.v1();
      final randomTeamTwoId = _uuid.v4();
      final randomTeamThreeId = _uuid.v4();
      final teamOne = TeamModel(
        id: _auth.currentUser!.uid,
        name: _auth.currentUser!.displayName,
        photo: _auth.currentUser!.photoURL,
      );
      final teamTwo = TeamModel(
        id: twoId.isEmpty ? randomTeamTwoId : twoId,
        name: twoName.isEmpty ? teamTwoName : twoName,
        photo: twoPhoto,
      );
      final teamThree = TeamModel(
        id: threeId.isEmpty ? randomTeamThreeId : threeId,
        name: threeName.isEmpty ? teamThreeName : threeName,
        photo: threePhoto,
      );
      final List<String> members = [teamOne.id!, teamTwo.id!, teamThree.id!]
        ..sort((a, b) => b.compareTo(a));
      gameModel = GameModel(
        id: randomGameId,
        name: selectedGame.value,
        members: members,
        createdAt: _createdAtTime,
        maxScore: maxScore,
        teams: [teamOne, teamTwo, teamThree],
      );
      await _fireStore
          .collection(AppStrings.gamesCollection)
          .doc(randomGameId)
          .set(gameModel.toMap())
          .whenComplete(() {
        CustomLoading.dismiss();
        Get.offNamed(AppRoute.gameView);
      });
    }
  }

  Future createGameFourTeamsOnlineMode(
      String twoName,
      String threeName,
      String fourName,
      String twoPhoto,
      String threePhoto,
      String fourPhoto) async {
    CustomLoading.show();

    final randomGameId = _uuid.v1();
    final randomTeamTwoId = _uuid.v4();
    final randomTeamThreeId = _uuid.v4();
    final randomTeamFourId = _uuid.v4();

    final teamOne = TeamModel(
        id: _auth.currentUser!.uid,
        name: _auth.currentUser!.displayName,
        photo: _auth.currentUser!.photoURL);
    final teamTwo =
        TeamModel(id: randomTeamTwoId, name: twoName, photo: twoPhoto);
    final teamThree =
        TeamModel(id: randomTeamThreeId, name: threeName, photo: threePhoto);
    final teamFour =
        TeamModel(id: randomTeamFourId, name: fourName, photo: fourPhoto);

    final List<String> members = [
      teamOne.id!,
      teamTwo.id!,
      teamThree.id!,
      teamFour.id!
    ]..sort((a, b) => b.compareTo(a));

    gameModel = GameModel(
      id: randomGameId,
      name: selectedGame.value,
      members: members,
      createdAt: _createdAtTime,
      maxScore: maxScore,
      teams: [teamOne, teamTwo, teamThree, teamFour],
    );
    await _fireStore
        .collection(AppStrings.gamesCollection)
        .doc(randomGameId)
        .set(gameModel.toMap())
        .whenComplete(() {
      CustomLoading.dismiss();
      Get.offNamed(AppRoute.gameView);
    });
  }

  void createGameFunctionOfflineMode() {
    if (selectedGame.isEmpty) {
      CustomLoading.toast(text: 'Selete Game');
    } else if (maxScoreController.text.isEmpty) {
      CustomLoading.toast(text: 'Max Score Required');
    } else if (selectedNum.value == '2'
        ? teamTwoNameController.text.isEmpty
        : selectedNum.value == '3'
            ? teamTwoNameController.text.isEmpty ||
                teamTwoNameController.text.isEmpty
            : teamTwoNameController.text.isEmpty ||
                teamTwoNameController.text.isEmpty ||
                teamFourNameController.text.isEmpty) {
      CustomLoading.toast(text: 'Teams Name Required');
    } else {
      _createGameOfflineMode();
    }
  }

  Future closeAndDeleteGame() async {
    CustomLoading.show();
    await _fireStore
        .collection(AppStrings.gamesCollection)
        .doc(gameModel.id)
        .delete()
        .whenComplete(() {
      CustomLoading.dismiss();
      Get.delete<GameController>();
      Get.offNamed(AppRoute.homeView);
    });
  }

  Future updateEndedgame() async {
    CustomLoading.show();

    List<TeamModel> teams() {
      List<TeamModel> list = [];
      if (selectedNum.value == '2') {
        list = [
          TeamModel(
              id: gameModel.teams![0].id,
              photo: gameModel.teams![0].photo,
              name: gameModel.teams![0].name,
              score: teamAPoints.value.toString(),
              isWinner: maxScore <= teamAPoints.value ? true : false),
          TeamModel(
              id: gameModel.teams![1].id,
              photo: gameModel.teams![1].photo,
              name: gameModel.teams![1].name,
              score: teamBPoints.value.toString(),
              isWinner: maxScore <= teamBPoints.value ? true : false)
        ];
      } else if (selectedNum.value == '3') {
        list = [
          TeamModel(
              id: gameModel.teams![0].id,
              photo: gameModel.teams![0].photo,
              name: gameModel.teams![0].name,
              score: teamAPoints.value.toString(),
              isWinner: maxScore <= teamAPoints.value ? true : false),
          TeamModel(
              id: gameModel.teams![1].id,
              photo: gameModel.teams![1].photo,
              name: gameModel.teams![1].name,
              score: teamBPoints.value.toString(),
              isWinner: maxScore <= teamBPoints.value ? true : false),
          TeamModel(
              id: gameModel.teams![2].id,
              photo: gameModel.teams![2].photo,
              name: gameModel.teams![2].name,
              score: teamCPoints.value.toString(),
              isWinner: maxScore <= teamCPoints.value ? true : false)
        ];
      } else {
        list = [
          TeamModel(
              id: gameModel.teams![0].id,
              photo: gameModel.teams![0].photo,
              name: gameModel.teams![0].name,
              score: teamAPoints.value.toString(),
              isWinner: maxScore <= teamAPoints.value ? true : false),
          TeamModel(
              id: gameModel.teams![1].id,
              photo: gameModel.teams![1].photo,
              name: gameModel.teams![1].name,
              score: teamBPoints.value.toString(),
              isWinner: maxScore <= teamBPoints.value ? true : false),
          TeamModel(
              id: gameModel.teams![2].id,
              photo: gameModel.teams![2].photo,
              name: gameModel.teams![2].name,
              score: teamCPoints.value.toString(),
              isWinner: maxScore <= teamCPoints.value ? true : false),
          TeamModel(
              id: gameModel.teams![3].id,
              photo: gameModel.teams![3].photo,
              name: gameModel.teams![3].name,
              score: teamDPoints.value.toString(),
              isWinner: maxScore <= teamDPoints.value ? true : false)
        ];
      }
      return list;
    }

    gameModel = GameModel(
        id: gameModel.id,
        name: gameModel.name,
        members: gameModel.members,
        createdAt: gameModel.createdAt,
        maxScore: gameModel.maxScore,
        winner: gameModel.getWinnerId(),
        isEnded: true,
        teams: teams());
    await _fireStore
        .collection(AppStrings.gamesCollection)
        .doc(gameModel.id)
        .update(gameModel.toMap())
        .whenComplete(() {
      CustomLoading.dismiss();
    });
  }

  Future screenShot() async {
    Uint8List? image = await screenShotController.capture();
    await (Permission.storage).request();
    final date = DateTime.now();
    final name = 'ScreenShot$date';
    await ImageGallerySaver.saveImage(image!, name: name);
    CustomLoading.toast(text: 'ScreenShot Done');
  }

  Future deletePerviousGame({required String gameId}) async {
    await _fireStore
        .collection(AppStrings.gamesCollection)
        .doc(gameId)
        .delete()
        .whenComplete(
            () => CustomLoading.toast(text: 'Game deleted successfully'))
        .onError(
            (error, stackTrace) => CustomLoading.toast(text: error.toString()));
  }

  Stream<List<GameModel>> getPreviousGames() {
    final result = FirebaseFirestore.instance
        .collection(AppStrings.gamesCollection)
        .where('members', arrayContains: _auth.currentUser!.uid)
        // .orderBy('createdAt', descending: true)
        .snapshots();
    return result.map((snapshot) {
      // Map each document snapshot into a GameModel object
      return snapshot.docs.map((doc) {
        return GameModel.fromMap(doc.data());
      }).toList();
    });
  }

  void createTeamsUi() {
    if (selectedGame.isEmpty) {
      CustomLoading.toast(text: 'Select Game');
    } else if (maxScoreController.text.isEmpty ||
        maxScoreController.text == '') {
      CustomLoading.toast(text: 'Max Score Required');
    } else if (selectedNum.value == '') {
      CustomLoading.toast(text: 'Select a team number');
      return;
    } else {
      isCreated = !isCreated;
      isCreated ? selectedNum.value : selectedNum.value = '';

      const model = TeamModel(id: '', name: '', photo: '');
      teamTwo = model;
      teamThree = model;
      teamFour = model;
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
        scoreListATeam.clear();
        update();
      }
    } else if (team == 'B') {
      if (scoreListBTeam.isNotEmpty) {
        int lastAdded = scoreListBTeam.removeLast();
        teamBPoints -= lastAdded;
        scoreListBTeam.clear();
        update();
      }
    } else if (team == 'C') {
      if (scoreListCTeam.isNotEmpty) {
        int lastAdded = scoreListCTeam.removeLast();
        teamCPoints -= lastAdded;
        scoreListCTeam.clear();
        update();
      }
    } else if (team == 'D') {
      if (scoreListDTeam.isNotEmpty) {
        int lastAdded = scoreListDTeam.removeLast();
        teamDPoints -= lastAdded;
        scoreListDTeam.clear();
        update();
      }
    }
  }

  Future setTeamImage(
      {required ImageSource source, required String pickedTeamNum}) async {
    try {
      final image = await _imagePicker.pickImage(source: source);
      if (image != null) {
        final bytes = await image.readAsBytes();
        if (pickedTeamNum == '2') {
          pickedTeamTwoImage = base64Encode(bytes);
        } else if (pickedTeamNum == '3') {
          pickedTeamThreeImage = base64Encode(bytes);
        } else {
          pickedTeamFourImage = base64Encode(bytes);
        }

        update();
      }
      return null;
    } on Exception catch (e) {
      final permissionStatus = await Permission.photos.status;
      if (permissionStatus.isDenied) {
        await AppFunctions.permissionsDialog();
      } else {
        CustomLoading.toast(text: e.toString());
      }
    }
  }

  // Future _uploadImage({
  //   required File file,
  //   required String userId,
  // }) async {
  //   CustomLoading.show();
  //   final String imagePath = file.path.split('.').last;
  //   final imageRef =
  //       _fireStorage.ref('TeamsImages').child('$userId/$userId.$imagePath');
  //   bool imageExists = await imageRef.getDownloadURL().then((value) {
  //     return true;
  //   }).catchError((error) {
  //     if (error.code == 'object-not-found') {
  //       return false;
  //     }
  //     throw error;
  //   });
  //   if (!imageExists) {
  //     final ref =
  //         _fireStorage.ref('TeamsImages').child('$userId/$userId.$imagePath');
  //     await ref.putFile(file);
  //     final String imageUrl = await ref.getDownloadURL();
  //     // pickedTeamImage = imageUrl;
  //     await _fireStore
  //         .collection(AppStrings.usersCollection)
  //         .doc(userId)
  //         .update({
  //       'teamPhotos': FieldValue.arrayUnion([imageUrl])
  //     });
  //   } else {
  //     CustomLoading.toast(text: 'Image already exists');
  //   }
  //   CustomLoading.dismiss();
  // }

  // Future<bool> _checkInternet() async {
  //   if (await _checker.hasConnection) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}
