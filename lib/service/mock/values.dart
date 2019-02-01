import '../../model/author.dart';
import '../../model/book.dart';
import '../../model/category.dart';
import '../../model/class.dart';
import '../../model/collection.dart';
import '../../model/editor.dart';
import '../../model/role.dart';
import '../../model/series.dart';
import '../../model/token.dart';
import '../../model/user.dart';

final mockUserInvalid = User(1, 'foo@invalid.com', 'fooInvalid', false, false);
final mockUserValid = User(2, 'foo@valid.com', 'fooValid', true, false);
final mockUserAdmin = User(3, 'foo@admin.com', 'fooAdmin', true, true);

final mockAuthTokenInvalid =
    AuthToken(mockUserInvalid, "tokeninvalid", "refreshtokeninvalid");
final mockAuthTokenValid =
    AuthToken(mockUserValid, "tokenvalid", "refreshtokenvalid");
final mockAuthTokenAdmin =
    AuthToken(mockUserAdmin, "tokenadmin", "refreshtokenadmin");
