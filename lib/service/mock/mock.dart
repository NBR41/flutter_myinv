import 'dart:async';
import 'dart:core';
import '../../model/book.dart';
import '../../model/token.dart';
import '../factory.dart';
import '../errors.dart';
import 'values.dart';

class Authenticate implements Authenticater {
  final String domain;
  Authenticate(String domain) : domain = domain;

  Future<AuthToken> login(String login, String password) {
    switch (login) {
      case 'bad':
        return Future.error(errBadRequest);
      case 'internal':
        return Future.error(errInternalServerError);
      case 'error':
        return Future.error("auth error");
        break;
      case 'warning':
        return Future.error("warning");
        break;
      case 'admin':
        return Future.value(mockAuthTokenAdmin);
        break;
      default:
        throw Exception('caca');
        break;
    }
  }
}

class MockModeler {
  Future<Book> getBook(String isbn) {
    return Future.delayed(Duration(seconds: 3), () {
      //return Book(1, 'isbn', 'bookname', null,null,null);
      return Future.error('Failed to load book');
    });
  }
}
