
import 'package:chat_app/ApplicationLayer/Services/User/CurrentUserService.dart';
import 'package:chat_app/DataLayer/Networking/Auth/SignUpWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/User/User.dart';
import 'package:flutter/foundation.dart';

class SignUpService {

  final _signUpWebAPIWorker = SignUpWebAPIWorker();
  final _currentUserService = CurrentUserService();

  Future<User> signUp({@required String name, @required String login, @required String password}) async {
    final user = await _signUpWebAPIWorker.signUp(name: name, login: login, password: password);
    await _currentUserService.saveCurrentUser(user);
    return user;
  }
}