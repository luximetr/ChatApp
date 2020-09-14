
import 'package:chat_app/DataLayer/Networking/Auth/SignUpWebAPIWorker.dart';
import 'package:flutter/foundation.dart';

class SignUpService {

  SignUpWebAPIWorker _signUpWebAPIWorker = SignUpWebAPIWorker();

  Future<void> signUp({@required String login, @required String password}) {
    return _signUpWebAPIWorker.signUp(login: login, password: password);
  }
}