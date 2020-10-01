
import 'package:chat_app/PresentationLayer/Screens/Auth/SignIn/Helpers/SignInScreenFormErrors.dart';

class SignInScreenFormValidator {
  var _errors = SignInScreenFormErrors();

  bool validate(String login, String password, Function(SignInScreenFormErrors errors) onFailure) {
    final isLoginValid = _validateLogin(login);
    final isPasswordValid = _validatePassword(password);
    final isValid = isLoginValid && isPasswordValid;
    if (!isValid) { onFailure(_errors); }
    return isValid;
  }

  bool _validateLogin(String login) {
    if (login.isEmpty) {
      _errors.loginError = 'Can not be empty';
      return false;
    }
    return true;
  }

  bool _validatePassword(String password) {
    if (password.isEmpty) {
      _errors.passwordError = 'Can not be empty';
      return false;
    }
    return true;
  }
}
