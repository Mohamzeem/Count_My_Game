import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:count_my_game/Core/Utils/app_strings.dart';
import 'package:count_my_game/Core/Widgets/custom_loading.dart';
import 'package:count_my_game/Models/user_friend.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ContactsController extends GetxController {
//   final FirebaseStorage _fireStorage = FirebaseStorage.instance;
//   final _storage = GetStorage();
  final _fireStore = FirebaseFirestore.instance;
  final _checker = InternetConnectionChecker();
  final _auth = FirebaseAuth.instance;
  TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
//     nameController.clear();
//     passwordController.dispose();
//     passwordController.clear();
    super.dispose();
  }

  Future addFriend() async {
    CustomLoading.show();
    final friendEmail = await _fireStore
        .collection(AppStrings.usersCollection)
        .where('email', isEqualTo: nameController.text.trim())
        .get();
    if (friendEmail.docs.isNotEmpty) {
      final friendId = friendEmail.docs.first['id'];
      final friendName = friendEmail.docs.first['name'];
      final friendPhoto = friendEmail.docs.first['photo'];

      FriendModel friendModel =
          FriendModel(id: friendId, name: friendName, photo: friendPhoto);
      await _fireStore
          .collection(AppStrings.usersCollection)
          .doc(_auth.currentUser!.uid)
          .update({
        'friends': FieldValue.arrayUnion([friendModel.toJson()])
      }).whenComplete(() {
        CustomLoading.toast(text: '$friendName added');
        nameController.clear();
        Get.back();
      }).onError((error, stackTrace) =>
              CustomLoading.toast(text: error.toString()));
    } else {
      CustomLoading.toast(text: 'Email not found');
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

  Future<bool> _checkInternet() async {
    if (await _checker.hasConnection) {
      return true;
    } else {
      return false;
    }
  }
}
