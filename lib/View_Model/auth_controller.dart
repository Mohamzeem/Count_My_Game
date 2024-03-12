import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:count_my_game/Core/Services/pref_key.dart';
import 'package:count_my_game/Core/Widgets/custom_loading.dart';
import 'package:count_my_game/Core/Routes/app_routes.dart';
import 'package:count_my_game/Core/Utils/app_strings.dart';
import 'package:count_my_game/Models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class AuthController extends GetxController {
  // AuthController();
  final _storage = GetStorage();
  final _fireStore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _checker = InternetConnectionChecker();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final RxString _name = "".obs;
  final RxString _email = "".obs;
  final RxString _password = "".obs;
  bool _isFirstTime = true;
  bool _showPassword = true;
  final Rx<UserModel> _offlineProfile = const UserModel().obs;

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
    nameController.text = _name.value;
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

  @override
  void onInit() async {
    super.onInit();
    await getOfflineProfile();
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

  Future logIn() async {
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
          await getOfflineProfile();
        } else {
          await getOfflineProfile();
        }
        _clearCons();
        CustomLoading.dismiss();
        Get.offNamed(AppRoute.homeView);
      }).then(
        (value) {
          CustomLoading.toast(text: 'Welcome ${value.user!.displayName!}');
        },
      ).onError(
        (error, stackTrace) {
          if (error.toString() == 'Null check operator used on a null value') {
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
  }

  Future register() async {
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

  Future<UserModel> getOfflineProfile() async {
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
        .then((value) => CustomLoading.toast(text: 'Logged Out Successfully'))
        .onError(
          (error, stackTrace) => CustomLoading.toast(text: error.toString()),
        );
  }

  Future resetPassword(
      {required String email, required BuildContext context}) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(
            email: '${email.trim()}${AppStrings.defaultEmail}')
        .whenComplete(() {
      CustomLoading.toast(text: 'Email sent Successfully, Check your email');
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => const LoginView(),
      //     ),
      //     (route) => false);
    }).onError(
      (error, stackTrace) => CustomLoading.toast(text: error.toString()),
    );
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

  void navigateByConnection() async {
    final id = GetStorage().read(PrefKeys.userId);
    // final id = SharedPref().getString(PrefKeys.userId);
    bool isConnected = await _checkInternet();
    debugPrint('offline id  $id');
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
}
