
import 'package:chat_app/DataLayer/Networking/Auth/SignInWebAPIWorker.dart';
import 'package:chat_app/ModelLayer/Business/User/User.dart';
import 'package:flutter/foundation.dart';

class SignInService {

  SignInWebAPIWorker _signInWebAPIWorker = SignInWebAPIWorker();

  Future<User> signIn({@required String login, @required String password}) {
    return _signInWebAPIWorker.signIn(login: login, password: password);
  }
}