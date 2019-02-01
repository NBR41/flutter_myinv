import '../model/token.dart';
import 'mock/mock.dart';
import 'auth.dart';
import 'storage.dart';

abstract class Authenticater {
  Future<AuthToken> login(String login, String password);
}

class ServiceFactory {
  final String domain;

  ServiceFactory(String domain) : domain = domain;

  AuthStateProvider getAuthStateProvider() {
    return AuthStateProvider(getAuthenticateService(), StorageHelper());
  }

  Authenticater getAuthenticateService() {
    return Authenticate(domain);
  }
}
