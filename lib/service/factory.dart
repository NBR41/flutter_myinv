import 'package:flutter/foundation.dart';
import '../model/token.dart';
import '../model/bookdetail.dart';
import '../screen/home/explore/filters/filters.dart';
import 'storage.dart';
import 'wrapper/auth.dart';

import 'mock/auth.dart';
import 'mock/book.dart';
import 'mock/models.dart';
import 'mock/user.dart';

abstract class AuthService {
  Future<AuthToken> login(String login, String password);
}

abstract class ModelService {
  Future<List<DynamicFilter>> getList(List<ExploreFilter> filters);
}

abstract class UserService {
  Future<bool> create(String email, String nickname, String password);
  Future<bool> requestResetPassword(String email);
}

abstract class BookService {
  Future<BookDetail> getByISBN(String isbn);
}

class ServiceFactory {
  final String domain;
  AuthStateProvider authState;
  AuthService _authServ;
  ModelService _modelServ;
  BookService _bookServ;
  UserService _userServ;

  ServiceFactory({@required this.domain});

  AuthStateProvider getAuthStateProvider() {
    if (authState == null) {
      authState = AuthStateProvider(
          authServ: getAuthService(), storageHelper: StorageHelper());
    }
    return authState;
  }

  AuthService getAuthService() {
    if (_authServ == null) {
      _authServ = MockAuth();
    }
    return _authServ;
  }

  ModelService getModelService() {
    if (_modelServ == null) {
      _modelServ = MockModels();
    }
    return _modelServ;
  }

  BookService getBookService() {
    if (_bookServ == null) {
      _bookServ = MockBook();
    }
    return _bookServ;
  }

  UserService getUserService() {
    if (_userServ == null) {
      _userServ = MockUser();
    }
    return _userServ;
  }
}
