
import 'package:chat_app/DataLayer/Caching/User/CurrentUserCacheWorker.dart';
import 'package:chat_app/ModelLayer/Business/User/User.dart';

class CurrentUserService {
  
  final _currentUserCacheWorker = CurrentUserCacheWorker();
  
  Future<User> getCachedCurrentUser() async {
    return _currentUserCacheWorker.fetchCurrentUser();
  }

  Future<String> getCachedCurrentUserId() async {
    final user = await getCachedCurrentUser();
    return user.id;
  }

  Future<void> saveCurrentUser(User user) async {
    return _currentUserCacheWorker.saveCurrentUser(user);
  }

  Future<bool> getHasCurrentUser() async {
    return await getCachedCurrentUser() != null;
  }

  Future<void> removeCurrentUser() async {
    return _currentUserCacheWorker.removeCurrentUser();
  }
}