
import 'package:chat_app/PresentationLayer/Screens/Auth/SignUp/Helpers/SignUpScreenForm.dart';
import 'package:chat_app/PresentationLayer/Screens/Auth/SignUp/Helpers/SignUpScreenFormErrors.dart';

class SignUpScreenFormValidator {
  
  var _errors = SignUpScreenFormErrors();
  
  bool validate(SignUpScreenForm form, {Function(SignUpScreenFormErrors) onErrors}) {
    final isNameValid = _validateName(form.name);
    final isLoginValid = _validateLogin(form.login);
    final isPasswordValid = _validatePassword(form.password);
    final isRepeatPasswordValid = _validateRepeatPassword(form.password, form.repeatPassword);

    final isValid = isNameValid && isLoginValid && isPasswordValid && isRepeatPasswordValid;
    if (!isValid) { onErrors(_errors); }
    return isValid;
  }

  bool _validateName(String name) {
    if (name.isEmpty) {
      _errors.nameError = _getEmptyError();
      return false;
    }
    return true;
  }

  bool _validateLogin(String login) {
    if (login.isEmpty) {
      _errors.loginError = _getEmptyError();
      return false;
    }
    return true;
  }

  bool _validatePassword(String password) {
    if (password.isEmpty) {
      _errors.passwordError = _getEmptyError();
      return false;
    }
    return true;
  }

  bool _validateRepeatPassword(String password, String repeatPassword) {
    if (repeatPassword.isEmpty) {
      _errors.repeatPasswordError = _getEmptyError();
      return false;
    } else if (repeatPassword != password) {
      _errors.repeatPasswordError = 'Passwords should match';
      return false;
    }
    return true;
  }

  String _getEmptyError() {
    return 'Can not be empty';
  }
}