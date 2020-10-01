
class SignInScreenFormErrors {
  String loginError;
  String passwordError;

  SignInScreenFormErrors({this.loginError, this.passwordError});

  void setAsInvalidCredentials() {
    final error = 'Invalid credentials';
    loginError = error;
    passwordError = error;
  }

  void clearLoginError() {
    loginError = null;
  }

  void clearPasswordError() {
    passwordError = null;
  }
}