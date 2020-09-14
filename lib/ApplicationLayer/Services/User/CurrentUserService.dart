
import 'package:chat_app/DataLayer/Caching/User/CurrentUserCacheWorker.dart';
import 'package:chat_app/ModelLayer/Business/User/User.dart';

class CurrentUserService {
  
  final _currentUserCacheWorker = CurrentUserCacheWorker();
  
  Future<User> getCachedCurrentUser() {
    return _currentUserCacheWorker.fetchCurrentUser();
  }

  Future<void> saveCurrentUser(User user) {
    return _currentUserCacheWorker.saveCurrentUser(user);
  }

  Future<bool> getHasCurrentUser() async {
    return await getCachedCurrentUser() != null;
  }
}