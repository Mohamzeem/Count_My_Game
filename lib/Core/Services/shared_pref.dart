import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref extends GetxService {
  SharedPreferences? prefs;

  Future<SharedPref> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future setString(String key, String stringValue) async {
    return await prefs!.setString(key, stringValue);
  }

  String? getString(String key) {
    return prefs!.getString(key);
  }

  Future setBoolean(String key, bool booleanValue) async {
    prefs!.setBool(key, booleanValue);
  }

  bool? getBoolean(String key) {
    return prefs!.getBool(key);
  }
}
