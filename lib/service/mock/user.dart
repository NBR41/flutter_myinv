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
    return Future.delayed(Duration(seconds: 5), () {
      return val;
    });
  }
}
