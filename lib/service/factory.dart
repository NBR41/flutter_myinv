import '../model/token.dart';
import 'mock/mock.dart';
import 'auth.dart';
import 'storage.dart';

abstract class Authenticater {
  Future<AuthToken> login(String login, String password);
}

class ServiceFactory {
  final String domain;
  AuthStateProvider authState;
  Authenticater auth;

  ServiceFactory(String domain) : domain = domain;

  AuthStateProvider getAuthStateProvider() {
    if (authState == null) {
      authState = AuthStateProvider(getAuthenticateService(), StorageHelper());
    }
    return authState;
  }

  Authenticater getAuthenticateService() {
    if (auth == null) {
      auth = Authenticate(domain);
    }
    return auth;
  }
}
