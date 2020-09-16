
import 'package:chat_app/ApplicationLayer/Services/User/CurrentUserService.dart';

class SignOutService {

  final _currentUserService = CurrentUserService();

  Future<void> signOut() {
    return _currentUserService.removeCurrentUser();
  }
}