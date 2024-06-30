import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:count_my_game/Core/Utils/app_strings.dart';
import 'package:count_my_game/Core/Widgets/custom_loading.dart';
import 'package:count_my_game/Models/friend_model.dart';
import 'package:count_my_game/Models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class FriendsController extends GetxController {
  final _fireStore = FirebaseFirestore.instance;
  final RxBool _fromFriendsTeamTwo = false.obs;
  final RxBool _fromFriendsTeamThree = false.obs;
  final RxBool _fromFriendsTeamFour = false.obs;
  List<FriendModel> _friendsList = [];
  final Rx<FriendModel> _friendOneModel = const FriendModel().obs;
  final Rx<FriendModel> _friendTwoModel = const FriendModel().obs;
  final Rx<FriendModel> _friendThreeModel = const FriendModel().obs;
  final Rx<FriendModel> _friendFourModel = const FriendModel().obs;
  UserModel friendFound = const UserModel();
  final _auth = FirebaseAuth.instance;
  TextEditingController nameController = TextEditingController();

  List<FriendModel> get friendsList => _friendsList;
  set friendsList(List<FriendModel> val) {
    _friendsList = val;
    update();
  }

  bool get fromFriendsTeamTwo => _fromFriendsTeamTwo.value;
  set fromFriendsTeamTwo(bool val) {
    _fromFriendsTeamTwo.value = val;
    update();
  }

  bool get fromFriendsTeamThree => _fromFriendsTeamThree.value;
  set fromFriendsTeamThree(bool val) {
    _fromFriendsTeamThree.value = val;
    update();
  }

  bool get fromFriendsTeamFour => _fromFriendsTeamFour.value;
  set fromFriendsTeamFour(bool val) {
    _fromFriendsTeamFour.value = val;
    update();
  }

  FriendModel get friendOne => _friendOneModel.value;
  set friendOne(FriendModel model) {
    _friendOneModel.value = model;
    update();
  }

  FriendModel get friendTwo => _friendTwoModel.value;
  set friendTwo(FriendModel model) {
    _friendTwoModel.value = model;
    update();
  }

  FriendModel get friendThree => _friendThreeModel.value;
  set friendThree(FriendModel model) {
    _friendThreeModel.value = model;
    update();
  }

  FriendModel get friendFour => _friendFourModel.value;
  set friendFour(FriendModel model) {
    _friendFourModel.value = model;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getFriendsForPick();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  Future addFriend() async {
    if (nameController.text == '') {
      CustomLoading.toast(
          text: 'Please enter email',
          toastPosition: EasyLoadingToastPosition.center);
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(nameController.text)) {
      CustomLoading.toast(text: 'Please enter a valid email');
    } else {
      CustomLoading.show();
      try {
        //^ get friend from users collection
        final result = await _fireStore
            .collection(AppStrings.usersCollection)
            .where('email', isEqualTo: nameController.text.trim())
            .get();

        //^ if friend found in users collection
        if (result.docs.isNotEmpty) {
          friendFound = UserModel.fromJson(result.docs[0].data());
          FriendModel friendModel = FriendModel(
            id: friendFound.id,
            name: friendFound.name,
            photo: friendFound.photo,
          );

          //^ if friend found in friends list
          friendsList = await getFriendsForPick();
          bool friendAdded =
              friendsList.any((element) => element.id == friendFound.id);

          if (friendAdded == true) {
            CustomLoading.toast(text: 'already added');
          } else {
            if (friendFound.email == nameController.text.trim() &&
                friendFound.id != _auth.currentUser!.uid) {
              await _fireStore
                  .collection(AppStrings.usersCollection)
                  .doc(_auth.currentUser!.uid)
                  .update({
                'friends': FieldValue.arrayUnion([friendModel.toJson()])
              }).then((_) {
                CustomLoading.toast(text: '${friendFound.name} added');
                nameController.clear();
                Get.back();
              });
            } else {
              CustomLoading.toast(text: 'Its Your email');
            }
          }
        } else {
          CustomLoading.toast(text: 'Invalid email');
        }
      } on FirebaseException catch (e) {
        CustomLoading.toast(text: e.message.toString());
      }
    }
    CustomLoading.dismiss();
  }

  Stream<List<FriendModel>> getFriends() async* {
    final result = _fireStore
        .collection(AppStrings.usersCollection)
        .doc(_auth.currentUser!.uid)
        .snapshots();

    await for (final event in result) {
      var data = event.data() as Map<String, dynamic>;
      final friendsList = List<FriendModel>.from(
        data['friends'].map(
          (friend) => FriendModel(
            name: friend['name'],
            photo: friend['photo'],
            id: friend['id'],
          ),
        ),
      );
      yield friendsList;
    }
  }

  Future<List<FriendModel>> getFriendsForPick() async {
    final snapshot = await _fireStore
        .collection(AppStrings.usersCollection)
        .doc(_auth.currentUser!.uid)
        .get();

    var data = snapshot.data() as Map<String, dynamic>;
    final list = List<FriendModel>.from(
      data['friends'].map(
        (friend) => FriendModel(
          name: friend['name'],
          photo: friend['photo'],
          id: friend['id'],
        ),
      ),
    );
    friendsList = list;
    return list;
  }

  Future deleteFriend({required String id, required String name}) async {
    final result = await _fireStore
        .collection(AppStrings.usersCollection)
        .doc(_auth.currentUser!.uid)
        .get();
    final List friendsList = result.get('friends');
    final updatedFriendsList =
        friendsList.where((friend) => friend['id'] != id).toList();
    await _fireStore
        .collection(AppStrings.usersCollection)
        .doc(_auth.currentUser!.uid)
        .update({
          'friends': updatedFriendsList,
        })
        .whenComplete(
            () => CustomLoading.toast(text: '$name deleted successfully'))
        .onError(
            (error, stackTrace) => CustomLoading.toast(text: error.toString()));
  }
}
