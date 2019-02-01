import 'dart:async';

import 'factory.dart';
import 'storage.dart';
import '../model/token.dart';

enum AuthState { LOGGED_IN, LOGGED_OUT }

class AuthStateProvider {
  final Authenticater authSrv;
  final StorageHelper storage;
  AuthToken token;

  AuthStateProvider(this.authSrv, this.storage);

  Future<bool> isLogged() async {
    if (token == null) {
      token = await storage.get();
    }
    token = await storage.get();
    return Future.value(token != null);
  }

  Future<void> logout() async {
    try {
      await storage.delete();
      token = null;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<AuthToken> login(String login, String password) async {
    try {
      token = await authSrv.login(login, password);
      await storage.save(token);
      return token;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
