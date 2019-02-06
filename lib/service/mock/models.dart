import '../../screen/home/explore/filters/filters.dart';
import 'values.dart';
import '../factory.dart';

class MockModels implements Modeler {
  Future<List<DynamicFilter>> getList(List<ExploreFilter> filters) {
    Future<List<DynamicFilter>> val;
    switch (filters.last.id) {
      case 1:
        val = Future.value(mockCategoryList);
        break;
      case 2:
        val = Future.value(mockClassList);
        break;
      case 4:
        val = Future.value(mockRoleList);
        break;
      case 8:
        val = Future.value(mockAuthorList);
        break;
      case 16:
        val = Future.value(mockEditorList);
        break;
      case 32:
        val = Future.value(mockCollectionList);
        break;
      case 64:
        val = Future.value(mockSeriesList);
        break;
      case 128:
        val = Future.value(mockBookList);
        break;
      case 256:
        val = Future.value(mockPrintList);
        break;
    }

    return Future.delayed(Duration(seconds: 3), () {
      return val;

      //return Future.error('Failed to load book');
    });
  }
}
