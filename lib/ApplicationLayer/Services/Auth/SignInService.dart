
import 'package:chat_app/ApplicationLayer/Services/User/CurrentUserService.dart';
import 'package:chat_app/DataLayer/Networking/Auth/SignInWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/User/User.dart';
import 'package:flutter/foundation.dart';

class SignInService {

  final _signInWebAPIWorker = SignInWebAPIWorker();
  final _currentUserService = CurrentUserService();

  Future<User> signIn({@required String login, @required String password}) async {
    final user = await _signInWebAPIWorker.signIn(login: login, password: password);
    await _currentUserService.saveCurrentUser(user);
    return user;
  }
}