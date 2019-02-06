import '../../model/author.dart';
import '../../model/book.dart';
import '../../model/category.dart';
import '../../model/class.dart';
import '../../model/collection.dart';
import '../../model/editor.dart';
import '../../model/print.dart';
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

final mockAuthor1 = Author(1, 'author 1');
final mockAuthor2 = Author(2, 'author 2');
final mockAuthor3 = Author(3, 'author 3');
final mockAuthorList = [mockAuthor1, mockAuthor2, mockAuthor3];

final mockCategory1 = Category(1, 'category 1');
final mockCategory2 = Category(2, 'category 2');
final mockCategory3 = Category(3, 'category 3');
final mockCategoryList = [mockCategory1, mockCategory2, mockCategory3];

final mockClass1 = Class(1, 'Class 1');
final mockClass2 = Class(2, 'Class 2');
final mockClass3 = Class(3, 'Class 3');
final mockClassList = [mockClass1, mockClass2, mockClass3];

final mockRole1 = Role(1, 'Role 1');
final mockRole2 = Role(2, 'Role 2');
final mockRole3 = Role(3, 'Role 3');
final mockRoleList = [mockRole1, mockRole2, mockRole3];

final mockEditor1 = Editor(1, 'Editor 1');
final mockEditor2 = Editor(2, 'Editor 2');
final mockEditor3 = Editor(3, 'Editor 3');
final mockEditorList = [mockEditor1, mockEditor2, mockEditor3];

final mockPrint1 = Print(1, 'Print 1');
final mockPrint2 = Print(2, 'Print 2');
final mockPrint3 = Print(3, 'Print 3');
final mockPrintList = [mockPrint1, mockPrint2, mockPrint3];

final mockCollection1 = Collection(1, 'Collection 1', 2, null, mockEditor2);
final mockCollection2 = Collection(2, 'Collection 2', 2, null, mockEditor2);
final mockCollection3 = Collection(3, 'Collection 3', 1, null, mockEditor1);
final mockCollectionList = [mockCollection1, mockCollection2, mockCollection3];

final mockSeries1 = Series(1, 'Series 1', 2, null, mockCategory2);
final mockSeries2 = Series(2, 'Series 2', 2, null, mockCategory2);
final mockSeries3 = Series(3, 'Series 3', 1, null, mockCategory1);
final mockSeriesList = [mockSeries1, mockSeries2, mockSeries3];

final mockBook1 = Book(1, 'isbn 1', 'BOOK 1', 3, null, mockSeries3);
final mockBook2 = Book(2, 'isbn 2', 'BOOK 2', 3, null, mockSeries3);
final mockBook3 = Book(3, 'isbn 3', 'BOOK 3', 3, null, mockSeries3);
final mockBookList = [mockBook1, mockBook2, mockBook3];
