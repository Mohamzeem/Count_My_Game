// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:count_my_game/Core/Services/pref_key.dart';
import 'package:count_my_game/Core/Utils/functions.dart';
import 'package:count_my_game/Core/Widgets/custom_loading.dart';
import 'package:count_my_game/Core/Routes/app_routes.dart';
import 'package:count_my_game/Core/Utils/app_strings.dart';
import 'package:count_my_game/Models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:permission_handler/permission_handler.dart';

class AuthController extends GetxController {
  final _fireStorage = FirebaseStorage.instance;
  final userBox = Hive.box(PrefKeys.profile);
  final ImagePicker _imagePicker = ImagePicker();
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _checker = InternetConnectionChecker();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final RxString _userName = "".obs;
  final RxString _email = "".obs;
  final RxString _password = "".obs;
  final RxString _userPhoto = ''.obs;
  bool _isFirstTime = true;
  bool _showPassword = true;

  bool get showPassword => _showPassword;
  set showPassword(bool value) {
    _showPassword = value;
    update();
  }

  String get name => nameController.text;
  set name(String val) {
    nameController.text = _userName.value;
    update();
  }

  String get email => emailController.text;
  set email(String val) {
    emailController.text = _email.value;
    update();
  }

  String get password => passwordController.text;
  set password(String val) {
    passwordController.text = _password.value;
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

  @override
  void onInit() async {
    super.onInit();
    _showConnectionStatus();
  }

  void _clearControllers() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  void logInFunction() {
    String msg = '';
    if (emailController.text == '') {
      msg = 'Email required';
    } else if (passwordController.text == '') {
      msg = 'Password required';
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text)) {
      CustomLoading.toast(text: 'Please enter a valid email');
    } else {
      _logIn();
    }
    CustomLoading.toast(text: msg);
  }

  Future _logIn() async {
    bool isConnected = await checkInternet();
    if (isConnected) {
      CustomLoading.show();
      try {
        // await _auth.currentUser!.reload();
        await _auth
            .signInWithEmailAndPassword(
          email: email.trim(),
          password: password,
        )
            .then(
          (value) async {
            await _getProfile();
            Get.offNamed(AppRoute.homeView);
            _clearControllers();
            CustomLoading.toast(text: 'Welcome ${value.user!.displayName!}');
          },
        );
      } on FirebaseAuthException catch (e) {
        CustomLoading.toast(text: e.code.toString());
      }
      CustomLoading.dismiss();
    } else {
      CustomLoading.toast(text: 'No internet connection');
    }
  }

  void registerFunction() {
    String msg = '';
    if (nameController.text == '') {
      msg = 'Name required';
    } else if (emailController.text == '') {
      msg = 'Email required';
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailController.text)) {
      CustomLoading.toast(text: 'Please enter a valid email');
    } else if (passwordController.text == '') {
      msg = 'Password required';
    } else {
      _register();
    }
    CustomLoading.toast(
        text: msg, toastPosition: EasyLoadingToastPosition.center);
  }

  Future _register() async {
    CustomLoading.show();
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password)
          .then((value) async {
        await _saveUserData(value.user!.uid);
        Get.back();
        _clearControllers();
        CustomLoading.toast(text: 'Account Created successfully');
      });
    } on FirebaseAuthException catch (e) {
      CustomLoading.toast(text: e.code.toString());
    }
  }

  Future _saveUserData(String id) async {
    await _auth.currentUser!.updateDisplayName(name);
    UserModel userModel = UserModel(
      name: name,
      id: id,
      email: email,
      photo: AppStrings.defaultAppPhoto,
    );
    await _auth.currentUser!.updatePhotoURL(AppStrings.defaultAppPhoto);
    await _fireStore
        .collection(AppStrings.usersCollection)
        .doc(id)
        .set(userModel.toJson());
  }

  Future<UserModel> _getProfile() async {
    final result = await _fireStore
        .collection(AppStrings.usersCollection)
        .doc(_auth.currentUser!.uid)
        .get();
    final user = UserModel.fromJson(result.data()!);
    // offlineProfile = user;
    newPhoto = user.photo!;
    newName = user.name!;
    final data = jsonEncode(user.toJson());
    await userBox.put(PrefKeys.profile, data);
    // await getOfflineProfile();
    if (user.photo != null || user.photo != "") {
      await _auth.currentUser!.updatePhotoURL(user.photo);
    }
    return user;
  }

  // Future<UserModel> getOfflineProfile() async {
  //   final result = await userBox.get(PrefKeys.profile);
  //   final data = jsonDecode(result!);
  //   UserModel userProfile = UserModel.fromJson(data);
  //   offlineProfile = userProfile;
  //   AppStrings.userId = userProfile.id;
  //   return offlineProfile;
  // }

  Future _uploadImage({
    required File file,
    required String userId,
  }) async {
    CustomLoading.show();
    try {
      final String imagePath = file.path.split('.').last;
      final ref = _fireStorage.ref('ProfileImages').child('$userId.$imagePath');
      await ref.putFile(file);
      final String imageUrl = await ref.getDownloadURL();
      await _auth.currentUser!.updatePhotoURL(imageUrl);
      await _fireStore
          .collection(AppStrings.usersCollection)
          .doc(userId)
          .update({'photo': imageUrl}).then((value) async {
        await _getProfile();
        // userImg = imageUrl;
        // await getOfflineProfile();
      });
    } on FirebaseException catch (e) {
      CustomLoading.toast(text: e.code.toString());
    }
    CustomLoading.toast(
        text: 'Image changed successfully',
        toastPosition: EasyLoadingToastPosition.bottom);
  }

  Future _changeUserName({required String userName}) async {
    bool isConnected = await checkInternet();
    if (isConnected) {
      CustomLoading.show();
      await _auth.currentUser!.updateDisplayName(userName);
      try {
        await _fireStore
            .collection(AppStrings.usersCollection)
            .doc(_auth.currentUser!.uid)
            .update({'name': userName}).then((value) async {
          await _getProfile();
          // await getOfflineProfile();
        }).then(
          (_) => CustomLoading.toast(text: 'Success, $userName updated'),
        );
      } on FirebaseException catch (e) {
        CustomLoading.toast(text: e.code.toString());
      }
    } else {
      CustomLoading.toast(text: 'No internet connection');
    }
  }

  Future _changePassword() async {
    bool isConnected = await checkInternet();
    if (isConnected) {
      CustomLoading.show();
      try {
        await _auth.currentUser!.updatePassword(newPassword).whenComplete(() {
          Get.back();
          CustomLoading.toast(text: 'Password Changed Successfully');
          _auth.signOut();
          passwordController.clear();
          Get.offNamed(AppRoute.emailLogInView);
        }).then((value) {
          CustomLoading.toast(text: 'Logged out, Please log in again');
        });
      } on FirebaseException catch (e) {
        CustomLoading.toast(text: e.code.toString());
      }
    } else {
      CustomLoading.toast(text: 'No internet connection');
    }
  }

  Future<bool> checkInternet() async {
    if (await _checker.hasConnection) {
      return true;
    } else {
      return false;
    }
  }

  void _showConnectionStatus() async {
    bool isConnected = await checkInternet();
    if (isConnected) {
      if (_isFirstTime) {
        _isFirstTime = false;
        return;
      }
      CustomLoading.toast(text: 'Internet connection Active');
    } else {
      CustomLoading.toast(text: 'No Internet connection');
    }
  }

  Future logOut() async {
    CustomLoading.show();
    bool isConnected = await checkInternet();
    if (isConnected) {
      try {
        await _auth.signOut().then((_) {
          userBox.delete(PrefKeys.profile);
          userBox.delete(PrefKeys.onelineMode);
          Get.offNamed(AppRoute.emailLogInView);
          CustomLoading.toast(
              text: 'Logged Out Successfully',
              toastPosition: EasyLoadingToastPosition.bottom);
        });
      } on FirebaseException catch (e) {
        CustomLoading.toast(text: e.toString());
      }
    }
    CustomLoading.dismiss();
  }

  Future forgotPassword() async {
    bool isConnected = await checkInternet();
    if (emailController.text == '') {
      CustomLoading.toast(text: 'Please enter email');
    } else if (!emailController.text.contains('@')) {
      CustomLoading.toast(text: 'Please enter a valid email');
    } else if (emailController.text.contains(' ')) {
      CustomLoading.toast(text: 'Email should not contain spaces');
    } else {
      if (isConnected) {
        try {
          await FirebaseAuth.instance
              .sendPasswordResetEmail(email: email.trim())
              .then((_) {
            CustomLoading.toast(
                text: 'Email sent Successfully, Check your email');
            Get.offNamed(AppRoute.emailLogInView);
          });
        } on FirebaseException catch (e) {
          CustomLoading.toast(text: e.code.toString());
        }
      }
    }
  }

  Future setProfileImage({required ImageSource source}) async {
    bool isConnected = await checkInternet();
    if (isConnected) {
      try {
        final image = await _imagePicker.pickImage(
          source: source,
          imageQuality: 80,
          maxHeight: 800,
          maxWidth: 800,
        );

        if (image != null) {
          _uploadImage(
            file: File(image.path),
            userId: FirebaseAuth.instance.currentUser!.uid,
          );
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
    } else {
      CustomLoading.toast(text: 'No internet connection');
    }
  }

  Future changeEmail({required String email}) async {
    bool isConnected = await checkInternet();
    if (isConnected) {
      CustomLoading.show();
      await _auth.currentUser!.verifyBeforeUpdateEmail(email);
      try {
        await _fireStore
            .collection(AppStrings.usersCollection)
            .doc(_auth.currentUser!.uid)
            .update({'email': email}).then(
                (_) => CustomLoading.toast(text: 'Success, $email updated'));
      } on FirebaseException catch (e) {
        CustomLoading.toast(text: e.code.toString());
      }
    }
    CustomLoading.toast(text: 'No internet connection');
  }

  void navigateByConnection(BuildContext context) async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Get.offNamed(AppRoute.emailLogInView);
      } else {
        Get.offNamed(AppRoute.homeView);
      }
    });
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

  void deleteAccount() async {
    bool isConnected = await checkInternet();
    if (isConnected) {
      CustomLoading.show();
      try {
        await _auth.currentUser!.delete().then((_) async {
          await FirebaseFirestore.instance
              .collection(AppStrings.usersCollection)
              .doc(_auth.currentUser!.uid)
              .delete();
          userBox.delete(PrefKeys.profile);
          CustomLoading.toast(text: 'Account Deleted Successfully');
          Get.offNamed(AppRoute.emailLogInView);
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'requires-recent-login') {
          CustomLoading.toast(
              text:
                  'The user must relogin before this operation can be executed');
        }
        CustomLoading.toast(text: e.code.toString());
      }
    } else {
      CustomLoading.toast(text: 'No internet connection');
    }
    CustomLoading.dismiss();
  }
}
