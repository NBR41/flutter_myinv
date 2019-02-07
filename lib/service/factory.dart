import '../model/token.dart';
import '../screen/home/explore/filters/filters.dart';
import 'mock/mock.dart';
import 'auth.dart';
import 'storage.dart';
import 'book.dart';
import 'mock/models.dart';

abstract class Authenticater {
  Future<AuthToken> login(String login, String password);
}

abstract class Modeler {
  Future<List<DynamicFilter>> getList(List<ExploreFilter> filters);
}

class ServiceFactory {
  final String domain;
  AuthStateProvider authState;
  Authenticater auth;
  Modeler modeler;
  BookGetter bg;

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

  Modeler getModeler() {
    if (modeler == null) {
      modeler = MockModels();
    }
    return modeler;
  }

  BookGetter getBookGetter() {
    if (bg == null) {
      bg = BookGetter();
    }
    return bg;
  }
}
