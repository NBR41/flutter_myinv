import 'dart:async';
import 'package:flutter/foundation.dart';
import '../factory.dart';
import '../storage.dart';
import '../../model/token.dart';

enum AuthState { LOGGED_IN, LOGGED_OUT }

class AuthStateProvider {
  final AuthService authServ;
  final StorageHelper storageHelper;

  AuthToken token;

  AuthStateProvider({@required this.authServ, @required this.storageHelper});

  Future<bool> isLogged() async {
    if (token == null) {
      token = await storageHelper.get();
    }
    token = await storageHelper.get();
    return Future.value(token != null);
  }

  Future<void> logout() async {
    try {
      await storageHelper.delete();
      token = null;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<AuthToken> login(String login, String password) async {
    try {
      token = await authServ.login(login, password);
      await storageHelper.save(token);
      return token;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
