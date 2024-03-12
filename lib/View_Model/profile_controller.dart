import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:count_my_game/Core/Routes/app_routes.dart';
import 'package:count_my_game/Core/Services/pref_key.dart';
import 'package:count_my_game/Core/Utils/app_strings.dart';
import 'package:count_my_game/Core/Widgets/custom_loading.dart';
import 'package:count_my_game/Models/user_model.dart';
import 'package:count_my_game/View_Model/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ProfileController extends GetxController {
  final FirebaseStorage _fireStorage = FirebaseStorage.instance;
  final _storage = GetStorage();
  final _fireStore = FirebaseFirestore.instance;
  final _checker = InternetConnectionChecker();
  final _auth = FirebaseAuth.instance;
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final RxString _userName = ''.obs;
  final RxString _password = ''.obs;
  final RxString _userPhoto = ''.obs;
  Rx<UserModel> userModel = const UserModel().obs;
  bool _showPassword = true;

  @override
  void onInit() async {
    super.onInit();

    debugPrint('refreshing');
    await AuthController().getOfflineProfile();
    await _getProfile();
  }

  @override
  void dispose() {
    nameController.dispose();
    nameController.clear();
    passwordController.dispose();
    passwordController.clear();
    super.dispose();
  }

  UserModel get profile => userModel.value;
  set profile(UserModel value) {
    userModel.value = value;
    update();
  }

  bool get showPassword => _showPassword;
  set showPassword(bool value) {
    _showPassword = value;
    update();
  }

  String get newName => nameController.text;
  set newName(String value) {
    nameController.text = _userName.value;
    update();
  }

  String get newPassword => passwordController.text;
  set newPassword(String value) {
    passwordController.text = _password.value;
    update();
  }

  String get newPhoto => _userPhoto.value;
  set newPhoto(String value) {
    _userPhoto.value = value;
    update();
  }

  // Future<UserModel> _getProfile() async {
  //   final result = await firebaseStore
  //       .collection(AppStrings.usersCollection)
  //       .doc(auth.currentUser!.uid)
  //       .get();
  //   final user = UserModel.fromJson(result.data()!);
  //   profile = user;
  //   newName = user.name!;
  //   newPhoto = user.photo!;
  //   return user;
  // }

  Future<UserModel> _getProfile() async {
    final result = await _fireStore
        .collection(AppStrings.usersCollection)
        .doc(_auth.currentUser!.uid)
        .get();
    final user = UserModel.fromJson(result.data()!);
    final data = jsonEncode(user.toJson());
    _storage.write(PrefKeys.profile, data);

    if (user.photo != null || user.photo != "") {
      await _auth.currentUser!.updatePhotoURL(user.photo);
    }
    return user;
  }

  Future setProfileImage() async {
    ImagePicker imagePicker = ImagePicker();

    final image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _uploadImage(
        file: File(image.path),
        userId: FirebaseAuth.instance.currentUser!.uid,
      );
    }
  }

  Future _uploadImage({
    required File file,
    required String userId,
  }) async {
    CustomLoading.show();
    final String imagePath = file.path.split('.').last;
    final ref = _fireStorage
        .ref('ProfileImages')
        .child('$userId/${DateTime.now().millisecondsSinceEpoch}.$imagePath');

    await ref.putFile(file);
    final String imageUrl = await ref.getDownloadURL();

    await _auth.currentUser!.updatePhotoURL(imageUrl);
    await _fireStore
        .collection(AppStrings.usersCollection)
        .doc(userId)
        .update({'photo': imageUrl}).then((value) async {
      await _getProfile();
      debugPrint('1');
      await AuthController().getOfflineProfile();
      debugPrint('2');
    });
    CustomLoading.toast(
        text: 'Success, Please refresh the page',
        toastPosition: EasyLoadingToastPosition.bottom);
  }

  Future _changeUserName({required String userName}) async {
    CustomLoading.show();
    await _auth.currentUser!.updateDisplayName(userName);
    await _fireStore
        .collection(AppStrings.usersCollection)
        .doc(_auth.currentUser!.uid)
        .update({'name': userName})
        .then((value) => _getProfile())
        .whenComplete(
          () => CustomLoading.toast(text: 'Success, $userName updated'),
        );
  }

  void changeUserNameFunction() {
    if (nameController.text.isEmpty) {
      CustomLoading.toast(
          text: 'Please enter a your user name',
          toastPosition: EasyLoadingToastPosition.center);
    } else {
      _changeUserName(userName: nameController.text);
      Get.back();
      nameController.clear();
    }
  }

  void changePasswordFunction() {
    if (passwordController.text.isEmpty) {
      CustomLoading.toast(
          text: 'Please enter your password',
          toastPosition: EasyLoadingToastPosition.center);
    } else {
      _changePassword();
    }
  }

  Future _changePassword() async {
    bool isConnected = await _checkInternet();
    if (isConnected) {
      CustomLoading.show();
      await _auth.currentUser!
          .updatePassword(newPassword)
          .whenComplete(() {
            Get.back();
            CustomLoading.toast(text: 'Password Changed Successfully');
            _auth.signOut();
            passwordController.clear();
            Get.offNamed(AppRoute.emailLogInView);
          })
          .onError((error, stackTrace) =>
              CustomLoading.toast(text: error.toString()))
          .then((value) {
            CustomLoading.toast(text: 'Logged out, Please log in again');
          });
    } else {
      CustomLoading.toast(text: 'No internet connection');
    }
  }

  Future changeEmail({required String email}) async {
    bool isConnected = await _checkInternet();
    if (isConnected) {
      CustomLoading.show();
      await _auth.currentUser!.verifyBeforeUpdateEmail(email);
      await _fireStore
          .collection(AppStrings.usersCollection)
          .doc(_auth.currentUser!.uid)
          .update({'email': email}).whenComplete(
              () => CustomLoading.toast(text: 'Success, $email updated'));
    }
    CustomLoading.toast(text: 'No internet connection');
  }

  Future<bool> _checkInternet() async {
    if (await _checker.hasConnection) {
      return true;
    } else {
      return false;
    }
  }
}
