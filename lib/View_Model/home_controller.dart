import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:count_my_game/Core/Utils/app_strings.dart';
import 'package:count_my_game/Core/Widgets/custom_loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class HomeController extends GetxController {
  final _checker = InternetConnectionChecker();
  final _fireStore = FirebaseFirestore.instance;
  final _fireStorage = FirebaseStorage.instance;
  final _auth = FirebaseAuth.instance;
  RxInt teamAPoints = 0.obs;
  RxInt teamBPoints = 0.obs;
  RxInt teamCPoints = 0.obs;
  RxInt teamDPoints = 0.obs;
  final RxString selected = ''.obs;
  final RxBool _gameCreated = false.obs;
  final teamOneController = TextEditingController();
  final teamTwoController = TextEditingController();
  final teamThreeController = TextEditingController();
  final teamFourController = TextEditingController();
  List<String> numList = ['2', '3', '4'];

  void dropDownValue(String val) => selected.value = val;
  bool get isCreated => _gameCreated.value;

  @override
  void dispose() {
    teamOneController.dispose();
    teamTwoController.dispose();
    teamThreeController.dispose();
    teamFourController.dispose();
    super.dispose();
  }

  void _clearCons() {
    teamOneController.clear();
    teamTwoController.clear();
    teamThreeController.clear();
    teamFourController.clear();
  }

  set isCreated(bool val) {
    _gameCreated.value = val;
    update();
  }

  void createNewGameFunction() {
    if (selected.value == '') {
      CustomLoading.toast(text: 'Select a team number');
      return;
    }
    isCreated = !isCreated;
    isCreated ? selected.value : selected.value = '';
    _clearCons();
  }

  void incrementScore({required String team, required int number}) {
    if (team == 'A') {
      teamAPoints += number;
      update();
    } else if (team == 'B') {
      teamBPoints += number;
      update();
    } else if (team == 'C') {
      teamCPoints += number;
      update();
    } else if (team == 'D') {
      teamDPoints += number;
      update();
    }
  }

  void decrementScore({required String team, required int number}) {
    if (team == 'A') {
      teamAPoints -= number;
      update();
    } else if (team == 'B') {
      teamBPoints -= number;
      update();
    } else if (team == 'C') {
      teamCPoints -= number;
      update();
    } else if (team == 'D') {
      teamDPoints -= number;
      update();
    }
  }

  void resetScore({required String team}) {
    if (team == 'A') {
      teamAPoints.value = 0;
      update();
    } else if (team == 'B') {
      teamBPoints.value = 0;
      update();
    } else if (team == 'C') {
      teamCPoints.value = 0;
      update();
    } else if (team == 'D') {
      teamDPoints.value = 0;
      update();
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
        .update({'teamPhotos': imageUrl}).then((value) async {
      // await _getProfile();
      // await _getOfflineProfile();
    });
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
