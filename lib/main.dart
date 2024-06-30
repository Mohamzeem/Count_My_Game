import 'package:count_my_game/Core/App/app_info.dart';
import 'package:count_my_game/Core/App/app_view.dart';
import 'package:count_my_game/Core/Services/pref_key.dart';
import 'package:count_my_game/Models/user_type_adaptor.dart';
import 'package:count_my_game/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserTypeAdaptor());
  await Hive.openBox(PrefKeys.profile);
  MyApp.setSystemUi();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
    runApp(const AppView());
  });
}
