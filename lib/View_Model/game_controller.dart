import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:count_my_game/Core/Routes/app_routes.dart';
import 'package:count_my_game/Core/Services/pref_key.dart';
import 'package:count_my_game/Core/Utils/app_strings.dart';
import 'package:count_my_game/Core/Utils/enums.dart';
import 'package:count_my_game/Core/Utils/functions.dart';
import 'package:count_my_game/Core/Utils/prints.dart';
import 'package:count_my_game/Core/Widgets/custom_loading.dart';
import 'package:count_my_game/Models/game_model.dart';
import 'package:count_my_game/Models/team_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:uuid/uuid.dart';

class GameController extends GetxController {
  final _checker = InternetConnectionChecker();
  final _fireStore = FirebaseFirestore.instance;
  final gameBox = Hive.box<GameModel>(PrefKeys.game);
  final _auth = FirebaseAuth.instance;
  final _uuid = const Uuid();
  final ImagePicker _imagePicker = ImagePicker();
  final AppMode onlineMode = AppMode.onlineMMode;
  RxInt teamAPoints = 0.obs;
  RxInt teamBPoints = 0.obs;
  RxInt teamCPoints = 0.obs;
  RxInt teamDPoints = 0.obs;
  RxList scoreListATeam = [].obs;
  RxList scoreListBTeam = [].obs;
  RxList scoreListCTeam = [].obs;
  RxList scoreListDTeam = [].obs;
  RxList userTeamPhotos = [].obs;
  final screenShotController = ScreenshotController();

  List<GameModel> _allGames = [];
  List<GameModel> get allGames => _allGames;
  set allGames(List<GameModel> games) {
    _allGames = games;
    update();
  }

  List<String> numList = ['2', '3', '4'];
  List<String> gamesList = ['Dominos', 'Cards', 'Playstation', 'Other'];
  final String _createdAtTime =
      DateTime.now().millisecondsSinceEpoch.toString();

  RxString selectedGame = ''.obs;
  void dropDownValueGamesList(String val) => selectedGame.value = val;

  RxString selectedNum = ''.obs;
  void dropDownValueNumList(String val) => selectedNum.value = val;

  RxBool _gameCreated = false.obs;
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

  String _pickedTeamTwoImage = '';
  final RxString _pickedTeamThreeImage = ''.obs;
  final RxString _pickedTeamFourImage = ''.obs;

  String get pickedTeamTwoImage => _pickedTeamTwoImage;
  set pickedTeamTwoImage(String val) {
    _pickedTeamTwoImage = val;
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

  final emailController = TextEditingController();
  String get searchEmail => emailController.text;
  set searchEmail(String val) {
    emailController.text = val;
    update();
  }

  final maxScoreController = TextEditingController();
  int get maxScore => int.parse(maxScoreController.text);
  set maxScore(int val) {
    int.parse(maxScoreController.text);
    update();
  }

  final newScoreController = TextEditingController();
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

  Future createTwoTeamsGameOnlineMode() async {
    bool isConnected = await _checkInternet();
    if (isConnected) {
      if (pickedTeamTwoImage == '' && teamTwo.photo! == '') {
        CustomLoading.toast(text: 'image Required');
      } else if (teamTwo.name == '' && teamTwoNameController.text.isEmpty) {
        CustomLoading.toast(text: 'Name Required');
      } else {
        CustomLoading.show();
        final randomGameId = _uuid.v1();
        teamOne = TeamModel(
          id: _auth.currentUser!.uid,
          name: _auth.currentUser!.displayName,
          photo: _auth.currentUser!.photoURL,
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

        try {
          await _fireStore
              .collection(AppStrings.gamesCollection)
              .doc(randomGameId)
              .set(gameModel.toMap());
        } on Exception catch (e) {
          CustomLoading.toast(text: e.toString());
        }
      }
      Get.offNamed(AppRoute.gameView);
      CustomLoading.dismiss();
    }
  }

  Future createGameThreeTeamsOnlineMode() async {
    if (pickedTeamTwoImage == '' && teamTwo.photo! == '') {
      CustomLoading.toast(text: 'Team Two image Required');
    } else if (teamTwo.name == '' && teamTwoNameController.text.isEmpty) {
      CustomLoading.toast(text: 'Team Two Name Required');
    } else if (pickedTeamThreeImage == '' && teamThree.photo! == '') {
      CustomLoading.toast(text: 'Team Three image Required');
    } else if (teamThree.name == '' && teamThreeNameController.text.isEmpty) {
      CustomLoading.toast(text: 'Team Three Name Required');
    } else {
      CustomLoading.show();
      final randomGameId = _uuid.v1();
      // final randomTeamTwoId = _uuid.v4();
      // final randomTeamThreeId = _uuid.v4();
      final teamOne = TeamModel(
        id: _auth.currentUser!.uid,
        name: _auth.currentUser!.displayName,
        photo: _auth.currentUser!.photoURL,
      );
      // final teamTwo = TeamModel(
      //   id: twoId.isEmpty ? randomTeamTwoId : twoId,
      //   name: twoName.isEmpty ? teamTwoName : twoName,
      //   photo: twoPhoto,
      // );
      // final teamThree = TeamModel(
      //   id: threeId.isEmpty ? randomTeamThreeId : threeId,
      //   name: threeName.isEmpty ? teamThreeName : threeName,
      //   photo: threePhoto,
      // );
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

      bool isConnected = await _checkInternet();
      if (isConnected) {
        await _fireStore
            .collection(AppStrings.gamesCollection)
            .doc(randomGameId)
            .set(gameModel.toMap())
            .then((_) {
          Get.offNamed(AppRoute.gameView);
        });
      } else {
        CustomLoading.toast(text: 'No internet connection');
      }
      CustomLoading.dismiss();
    }
  }

  Future createGameFourTeamsOnlineMode() async {
    if (pickedTeamTwoImage == '' && teamTwo.photo! == '') {
      CustomLoading.toast(text: 'Team Two image Required');
    } else if (teamTwo.name == '' && teamTwoNameController.text.isEmpty) {
      CustomLoading.toast(text: 'Team Two Name Required');
    } else if (pickedTeamThreeImage == '' && teamThree.photo! == '') {
      CustomLoading.toast(text: 'Team Three image Required');
    } else if (teamThree.name == '' && teamThreeNameController.text.isEmpty) {
      CustomLoading.toast(text: 'Team Three Name Required');
    } else if (pickedTeamFourImage == '' && teamFour.photo! == '') {
      CustomLoading.toast(text: 'Team Four image Required');
    } else if (teamFour.name == '' && teamFourNameController.text.isEmpty) {
      CustomLoading.toast(text: 'Team Four Name Required');
    } else {
      CustomLoading.show();

      final randomGameId = _uuid.v1();
      // final randomTeamTwoId = _uuid.v4();
      // final randomTeamThreeId = _uuid.v4();
      // final randomTeamFourId = _uuid.v4();

      final teamOne = TeamModel(
        id: _auth.currentUser!.uid,
        name: _auth.currentUser!.displayName,
        photo: _auth.currentUser!.photoURL,
      );
      // final teamTwo = TeamModel(
      //   id: twoId.isEmpty ? randomTeamTwoId : twoId,
      //   name: twoName.isEmpty ? teamTwoName : twoName,
      //   photo: twoPhoto,
      // );
      // final teamThree = TeamModel(
      //   id: threeId.isEmpty ? randomTeamThreeId : threeId,
      //   name: threeName.isEmpty ? teamThreeName : threeName,
      //   photo: threePhoto,
      // );
      // final teamFour = TeamModel(
      //   id: fourId.isEmpty ? randomTeamFourId : fourId,
      //   name: fourName.isEmpty ? teamFourName : fourName,
      //   photo: fourPhoto,
      // );

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

      bool isConnected = await _checkInternet();
      if (isConnected) {
        await _fireStore
            .collection(AppStrings.gamesCollection)
            .doc(randomGameId)
            .set(gameModel.toMap())
            .then((_) {
          Get.offNamed(AppRoute.gameView);
        });
      } else {
        CustomLoading.toast(text: 'No internet connection');
      }
      CustomLoading.dismiss();
    }
  }

  Future closeAndDeleteGame() async {
    bool isConnected = await _checkInternet();
    if (isConnected) {
      CustomLoading.show();
      try {
        await _fireStore
            .collection(AppStrings.gamesCollection)
            .doc(gameModel.id)
            .delete()
            .then((_) {
          Get.offNamed(AppRoute.homeView);
          Get.delete<GameController>();
          CustomLoading.dismiss();
        });
      } on Exception catch (e) {
        CustomLoading.toast(text: e.toString());
      }
    } else {
      Get.delete<GameController>();
      Get.offAllNamed(AppRoute.homeView);
    }
  }

  Future uploadOfflineGames() async {
    final randomGameId = _uuid.v1();
    var games = gameBox.values;
    bool isConnected = await _checkInternet();
    if (games.isNotEmpty && isConnected) {
      for (GameModel element in games) {
        await _fireStore
            .collection(AppStrings.gamesCollection)
            .doc(randomGameId)
            .set(element.toMap());
        await gameBox.delete(PrefKeys.game);
      }
      debugPrint('##### games saved in database');
      getPreviousGames();
    }
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
              photo:
                  pickedTeamTwoImage.isEmpty ? gameModel.teams![1].photo : "",
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
              photo:
                  pickedTeamTwoImage.isEmpty ? gameModel.teams![1].photo : "",
              name: gameModel.teams![1].name,
              score: teamBPoints.value.toString(),
              isWinner: maxScore <= teamBPoints.value ? true : false),
          TeamModel(
              id: gameModel.teams![2].id,
              photo:
                  pickedTeamThreeImage.isEmpty ? gameModel.teams![2].photo : "",
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
              photo:
                  pickedTeamTwoImage.isEmpty ? gameModel.teams![1].photo : "",
              name: gameModel.teams![1].name,
              score: teamBPoints.value.toString(),
              isWinner: maxScore <= teamBPoints.value ? true : false),
          TeamModel(
              id: gameModel.teams![2].id,
              photo:
                  pickedTeamThreeImage.isEmpty ? gameModel.teams![2].photo : "",
              name: gameModel.teams![2].name,
              score: teamCPoints.value.toString(),
              isWinner: maxScore <= teamCPoints.value ? true : false),
          TeamModel(
              id: gameModel.teams![3].id,
              photo:
                  pickedTeamFourImage.isEmpty ? gameModel.teams![3].photo : "",
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
      isEnded: true,
      teams: teams(),
    );
    bool isConnected = await _checkInternet();

    if (isConnected) {
      try {
        await _fireStore
            .collection(AppStrings.gamesCollection)
            .doc(gameModel.id)
            .update(gameModel.toMap())
            .then((_) {
          getPreviousGames();
        });
      } on Exception catch (e) {
        CustomLoading.toast(text: e.toString());
      }
    }
    CustomLoading.dismiss();
  }

  Future screenShot() async {
    Uint8List? image = await screenShotController.capture();
    await (Permission.storage).request();
    final date = DateTime.now();
    final name = 'ScreenShot$date';
    await ImageGallerySaver.saveImage(image!, name: name);
    CustomLoading.toast(text: 'ScreenShot Done');
  }

  Future deletePerviousGame(int index, {required String gameId}) async {
    bool isConnected = await _checkInternet();
    if (isConnected) {
      await _fireStore
          .collection(AppStrings.gamesCollection)
          .doc(gameId)
          .delete()
          .whenComplete(() {
        CustomLoading.toast(text: 'Game deleted successfully');
      }).onError((error, stackTrace) =>
              CustomLoading.toast(text: error.toString()));
    } else {
      gameBox.deleteAt(index);
      CustomLoading.toast(text: 'Game deleted successfully');
    }
    getPreviousGames();
  }

  Future<List<GameModel>> getPreviousGames() async {
    bool isConnected = await _checkInternet();
    if (isConnected) {
      try {
        CustomLoading.show();
        var result = await FirebaseFirestore.instance
            .collection(AppStrings.gamesCollection)
            .where('members', arrayContains: _auth.currentUser!.uid)
            .get();
        final games =
            result.docs.map((e) => GameModel.fromMap(e.data())).toList();
        //^ arrange list by created time
        allGames = List.from(
            games..sort((a, b) => b.createdAt!.compareTo(a.createdAt!)));
        CustomLoading.dismiss();
      } on Exception catch (e) {
        CustomLoading.toast(text: e.toString());
      }
    }
    return allGames;
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
          // Prints.debug(message: pickedTeamTwoImage);
        } else if (pickedTeamNum == '3') {
          pickedTeamThreeImage = base64Encode(bytes);
        } else {
          pickedTeamFourImage = base64Encode(bytes);
        }
      } else {
        return;
      }
    } on Exception catch (e) {
      final permissionStatus = await Permission.photos.status;
      if (permissionStatus.isDenied) {
        await AppFunctions.permissionsDialog();
      } else {
        CustomLoading.toast(text: e.toString());
      }
    }
  }

  Future<bool> _checkInternet() async {
    if (await _checker.hasConnection) {
      return true;
    } else {
      return false;
    }
  }
}



 //TODO: Try image picker from chatgpt

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: ImagePickerSave(),
//     );
//   }
// }

// class ImagePickerSave extends StatefulWidget {
//   @override
//   _ImagePickerSaveState createState() => _ImagePickerSaveState();
// }

// class _ImagePickerSaveState extends State<ImagePickerSave> {
//   File? _image;
//   final ImagePicker _picker = ImagePicker();
//   final DatabaseReference _database = FirebaseDatabase.instance.ref(); // For Realtime Database
//   // final CollectionReference _collection = FirebaseFirestore.instance.collection('images'); // For Firestore

//   Future<void> _pickImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//       });
//     }
//   }

//   Future<void> _saveImagePath() async {
//     if (_image == null) return;
//     try {
//       String imagePath = _image!.path;
//       await _database.child('images').push().set({'path': imagePath}); // For Realtime Database
//       // await _collection.add({'path': imagePath}); // For Firestore
//     } catch (e) {
//       print('Error saving image path: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Picker & Save Path'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _image == null
//                 ? Text('No image selected.')
//                 : Image.file(_image!),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _pickImage,
//               child: Text('Pick Image from Gallery'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _saveImagePath,
//               child: Text('Save Image Path to Firebase'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

