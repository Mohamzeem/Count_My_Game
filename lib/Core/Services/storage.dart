import 'package:get_storage/get_storage.dart';

class AppStorage {
  GetStorage storage = GetStorage();

  Future initStorage() async {
    await GetStorage.init();
  }

  Future setString(String key, String stringValue) async {
    return await storage.write(key, stringValue);
  }

  String? getString(String key) {
    return storage.read(key);
  }

  Future removeString(String key) {
    return storage.remove(key);
  }
}
