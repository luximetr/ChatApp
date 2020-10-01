
import 'package:flutter/foundation.dart';

class SignUpScreenForm {
  String name;
  String login;
  String password;
  String repeatPassword;

  SignUpScreenForm({
    @required this.name,
    @required this.login,
    @required this.password,
    @required this.repeatPassword,
  });
}