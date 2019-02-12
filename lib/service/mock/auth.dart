import 'dart:async';
import 'dart:core';
import '../../model/token.dart';
import '../factory.dart';
import '../errors.dart';
import 'values.dart';

class MockAuth implements AuthService {
  Future<AuthToken> login(String login, String password) {
    Future<AuthToken> val;
    switch (login) {
      case 'bad':
        val = Future.error(errBadRequest);
        break;
      case 'internal':
        val = Future.error(errInternalServerError);
        break;
      case 'error':
        val = Future.error("auth error");
        break;
      case 'warning':
        val = Future.error("warning");
        break;
      case 'admin':
        val = Future.value(mockAuthTokenAdmin);
        break;
      default:
        throw Exception('caca');
        break;
    }
    return Future.delayed(Duration(seconds: 2), () {
      return val;
    });
  }
}
