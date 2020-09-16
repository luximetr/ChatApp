
import 'package:localstorage/localstorage.dart';

class PreferencesStorage {

  final _storage = new LocalStorage('chat_app_json_storage');

  Future<void> saveObject(String key, Map<String, dynamic> value) async {
    await _storage.ready;
    return _storage.setItem(key, value);
  }

  Future<Map<String, dynamic>> getObject(String key) async {
    await _storage.ready;
    return _storage.getItem(key);
  }

  Future<void> removeObject(String key) async {
    await _storage.ready;
    return _storage.deleteItem(key);
  }
}