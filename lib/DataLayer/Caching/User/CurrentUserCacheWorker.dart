
import 'package:chat_app/DataLayer/Caching/Base/PreferencesStorage.dart';
import 'package:chat_app/ModelLayer/Business/User/User.dart';
import 'package:chat_app/ModelLayer/Business/User/UserJSONConverter.dart';

class CurrentUserCacheWorker {

  final _storage = PreferencesStorage();
  final _userJSONConverter = UserJSONConverter();
  final _key = 'currentUser';
  
  Future<void> saveCurrentUser(User user) async {
    final json = _userJSONConverter.toJSON(user);
    try {
      return _storage.saveObject(_key, json);
    } catch (exception) {
      print('Save current user error: $exception');
    }
  }
  
  Future<User> fetchCurrentUser() async {
    final json = await _storage.getObject(_key);
    return _userJSONConverter.toUser(json);
  }
}