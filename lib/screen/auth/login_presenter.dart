import '../../model/token.dart';
import '../../service/auth.dart';

abstract class LoginScreenContract {
  void onLoginSuccess(AuthToken token);
  void onLoginError(String errorTxt);
}

class LoginScreenPresenter {
  LoginScreenContract _view;
  AuthStateProvider auth;

  LoginScreenPresenter(this._view, this.auth);

  doLogin(String login, String password) {
    try {
      auth
          .login(login, password)
          .then((AuthToken token) => _view.onLoginSuccess(token))
          .catchError((error) => _view.onLoginError(error.toString()));
    } catch (e) {
      _view.onLoginError(e.toString());
    }
  }
}
