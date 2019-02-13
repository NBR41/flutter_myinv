import '../errors.dart';
import '../factory.dart';

class MockUser implements UserService {
  Future<bool> create(String email, String nickname, String password) async {
    Future<bool> val;
    switch (nickname) {
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
        val = Future.value(true);
        break;
      default:
        throw Exception('caca');
        break;
    }
    return Future.delayed(Duration(seconds: 3), () {
      return val;
    });
  }

  Future<bool> requestResetPassword(String email) async {
    Future<bool> val;
    switch (email) {
      case 'bad@foo.com':
        val = Future.error(errBadRequest);
        break;
      case 'internal@foo.com':
        val = Future.error(errInternalServerError);
        break;
      case 'error@foo.com':
        val = Future.error("auth error");
        break;
      case 'warning@foo.com':
        val = Future.error("warning");
        break;
      case 'admin@foo.com':
        val = Future.value(true);
        break;
      default:
        throw Exception('caca');
        break;
    }
    return Future.delayed(Duration(seconds: 3), () {
      return val;
    });
  }
}
