import '../../service/auth.dart';

abstract class AuthObserver {
  void onAuthStateChanged(AuthState state);
}

class AuthObservable {
  AuthStateProvider auth;
  List<AuthObserver> _observers;

  AuthObservable(this.auth) {
    _observers = new List<AuthObserver>();
    checkState();
  }
  void checkState() async {
    try {
      var isLoggedIn = await auth.isLogged();
      if (isLoggedIn) {
        notify(AuthState.LOGGED_IN);
      } else {
        notify(AuthState.LOGGED_OUT);
      }
    } catch (e) {
      notify(AuthState.LOGGED_OUT);
    }
  }

  void subscribe(AuthObserver observer) {
    _observers.add(observer);
  }

  void dispose(AuthObserver observer) {
    for (var l in _observers) {
      if (l == observer) {
        _observers.remove(l);
      }
    }
  }

  void notify(AuthState state) {
    _observers.forEach((AuthObserver s) => s.onAuthStateChanged(state));
  }
}
