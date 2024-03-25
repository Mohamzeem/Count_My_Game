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
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:permission_handler/permission_handler.dart';

class AuthController extends GetxController {
  final _fireStorage = FirebaseStorage.instance;
  final _storage = GetStorage();
  final ImagePicker _imagePicker = ImagePicker();
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _checker = InternetConnectionChecker();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final Rx<UserModel> _offlineProfile = const UserModel().obs;
  final RxString _userName = "".obs;
  final RxString _email = "".obs;
  final RxString _password = "".obs;
  final RxString _userPhoto = ''.obs;
  bool _isFirstTime = true;
  bool _showPassword = true;

  UserModel get offlineProfile => _offlineProfile.value;
  set offlineProfile(UserModel user) {
    _offlineProfile.value = user;
    update();
  }

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
    await _getOfflineProfile();
    _showConnectionStatus();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _clearCons() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  Future _logIn() async {
    bool isConnected = await _checkInternet();
    if (isConnected) {
      try {
        CustomLoading.show();
        await _auth
            .signInWithEmailAndPassword(
          email: '${email.trim()}${AppStrings.defaultEmail}',
          password: password,
        )
            .whenComplete(() async {
          bool isConnected = await _checkInternet();
          if (isConnected) {
            await _getProfile();
            await _getOfflineProfile();
          } else {
            await _getOfflineProfile();
          }
          CustomLoading.dismiss();
          Get.offNamed(AppRoute.homeView);
          _clearCons();
        }).then(
          (value) {
            CustomLoading.toast(text: 'Welcome ${value.user!.displayName!}');
          },
        ).onError(
          (error, stackTrace) {
            if (error.toString() ==
                'Null check operator used on a null value') {
              CustomLoading.toast(text: 'Wrong email or password');
            } else {
              CustomLoading.toast(text: error.toString());
            }
          },
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          CustomLoading.toast(text: 'No user found for that email');
        } else if (e.code == 'wrong-password') {
          CustomLoading.toast(text: 'Wrong password provided for that user');
        }
      } catch (e) {
        CustomLoading.toast(text: e.toString());
      }
    } else {
      CustomLoading.toast(text: 'No internet connection');
    }
  }

  Future _register() async {
    try {
      CustomLoading.show();
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: '${email.trim()}${AppStrings.defaultEmail}',
            password: password,
          )
          .whenComplete(() {
            _saveUserData();
            Get.back();
          })
          .then(
            (value) =>
                CustomLoading.toast(text: 'Account Created successfully'),
          )
          .onError((error, stackTrace) =>
              CustomLoading.toast(text: error.toString()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomLoading.toast(text: 'The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        CustomLoading.toast(text: 'The account already exists for that email');
      }
    } catch (e) {
      CustomLoading.toast(text: e.toString());
    }
  }

  Future _saveUserData() async {
    await _auth.currentUser!.updateDisplayName(name);
    UserModel userModel = UserModel(
      name: name,
      id: _auth.currentUser!.uid,
      email: email,
    );
    await _fireStore
        .collection(AppStrings.usersCollection)
        .doc(_auth.currentUser!.uid)
        .set(userModel.toJson());
  }

  Future<UserModel> _getProfile() async {
    final result = await _fireStore
        .collection(AppStrings.usersCollection)
        .doc(_auth.currentUser!.uid)
        .get();
    final user = UserModel.fromJson(result.data()!);
    newPhoto = user.photo!;
    newName = user.name!;
    final data = jsonEncode(user.toJson());
    _storage.write(PrefKeys.profile, data);
    // SharedPref().setString(PrefKeys.profile, data);
    _storage.write(PrefKeys.userId, user.id!);
    // SharedPref().setString(PrefKeys.userId, user.id!);

    if (user.photo != null || user.photo != "") {
      await _auth.currentUser!.updatePhotoURL(user.photo);
    }
    return user;
  }

  Future<UserModel> _getOfflineProfile() async {
    final result = _storage.read(PrefKeys.profile);
    // final result = SharedPref().getString(PrefKeys.profile);
    final data = jsonDecode(result!);
    UserModel userProfile = UserModel.fromJson(data);
    offlineProfile = userProfile;

    // UserModel offlineProfile =
    //     UserModel.fromJson(jsonDecode(GetStorage().read(PrefKeys.profile)));
    AppStrings.userId = userProfile.id;
    debugPrint('Offline Name ${userProfile.name}');
    return userProfile;
  }

  Future _uploadImage({
    required File file,
    required String userId,
  }) async {
    CustomLoading.show();
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
      await _getOfflineProfile();
    });
    CustomLoading.toast(
        text: 'Image changed successfully',
        toastPosition: EasyLoadingToastPosition.bottom);
  }

  Future _changeUserName({required String userName}) async {
    bool isConnected = await _checkInternet();
    if (isConnected) {
      CustomLoading.show();
      await _auth.currentUser!.updateDisplayName(userName);
      await _fireStore
          .collection(AppStrings.usersCollection)
          .doc(_auth.currentUser!.uid)
          .update({'name': userName}).then((value) async {
        await _getProfile();
        await _getOfflineProfile();
      }).whenComplete(
        () => CustomLoading.toast(text: 'Success, $userName updated'),
      );
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

  Future<bool> _checkInternet() async {
    if (await _checker.hasConnection) {
      return true;
    } else {
      return false;
    }
  }

  void _showConnectionStatus() async {
    bool isConnected = await _checkInternet();
    if (isConnected) {
      if (_isFirstTime) {
        _isFirstTime = false;
        return;
      }
      CustomLoading.toast(text: 'Internet connection is active');
    } else {
      CustomLoading.toast(text: 'Internet connection is disconnected');
    }
  }

  Future logOut() async {
    CustomLoading.show();
    await _auth
        .signOut()
        .whenComplete(() {
          CustomLoading.dismiss();
          _storage.remove(PrefKeys.userId);
          _storage.remove(PrefKeys.profile);
          Get.offNamed(AppRoute.emailLogInView);
        })
        .then(
          (value) => CustomLoading.toast(
              text: 'Logged Out Successfully',
              toastPosition: EasyLoadingToastPosition.bottom),
        )
        .onError(
          (error, stackTrace) => CustomLoading.toast(text: error.toString()),
        );
  }

  Future forgotPassword() async {
    bool isConnected = await _checkInternet();
    if (isConnected) {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(
              email: '${email.trim()}${AppStrings.defaultEmail}')
          .whenComplete(() {
        CustomLoading.toast(text: 'Email sent Successfully, Check your email');
        Get.offNamed(AppRoute.emailLogInView);
      }).onError(
        (error, stackTrace) => CustomLoading.toast(text: error.toString()),
      );
    }
  }

  Future setProfileImage({bool fromCamera = true}) async {
    bool isConnected = await _checkInternet();
    if (isConnected) {
      try {
        final image = fromCamera
            ? await _imagePicker.pickImage(source: ImageSource.camera)
            : await _imagePicker.pickImage(source: ImageSource.gallery);
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

  void navigateByConnection() async {
    // final id = GetStorage().read(PrefKeys.userId);
    final id = offlineProfile.id;
    bool isConnected = await _checkInternet();
    if (id == '' || id == null || id.isEmpty) {
      if (isConnected) {
        Get.offNamed(AppRoute.emailLogInView);
      } else {
        Get.offNamed(AppRoute.guestLogInView);
      }
    } else {
      Get.offNamed(AppRoute.homeView);
    }
  }

  void fromGuestToLoginIfConnected() async {
    bool isConnected = await _checkInternet();
    if (isConnected) {
      Get.toNamed(AppRoute.emailLogInView);
    } else {
      CustomLoading.toast(
          text: 'No internet connection',
          toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  void logInFunction() {
    String msg = '';
    if (emailController.text == '') {
      msg = 'Email required';
    } else if (passwordController.text == '') {
      msg = 'Password required';
    } else {
      _logIn();
    }
    CustomLoading.toast(
        text: msg, toastPosition: EasyLoadingToastPosition.center);
  }

  void registerFunction() {
    String msg = '';
    if (nameController.text == '') {
      msg = 'Name required';
    } else if (passwordController.text == '') {
      msg = 'Email required';
    } else if (passwordController.text == '') {
      msg = 'Password required';
    } else {
      _register();
    }
    CustomLoading.toast(
        text: msg, toastPosition: EasyLoadingToastPosition.center);
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
}
