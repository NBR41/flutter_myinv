abstract class DynamicFilter {
  int getID();
  String getName();
  String getFullName();
}

class ExploreFilter {
  final int id;
  final String txt;
  DynamicFilter filter;
  Future<List<DynamicFilter>> list;

  ExploreFilter(this.id, this.txt);

  void resetFilter() {
    filter = null;
    list = null;
  }
}

final int categoryID = 1;
final int classID = 2;
final int roleID = 4;
final int authorID = 8;
final int editorID = 16;
final int collectionID = 32;
final int seriesID = 64;
final int bookID = 128;
final int printID = 256;

final filters = {
  categoryID: ExploreFilter(categoryID, "Categories"),
  classID: ExploreFilter(classID, "Classes"),
  roleID: ExploreFilter(roleID, "Roles"),
  authorID: ExploreFilter(authorID, "Authors"),
  editorID: ExploreFilter(editorID, "Editors"),
  collectionID: ExploreFilter(collectionID, "Collections"),
  seriesID: ExploreFilter(seriesID, "Series"),
  bookID: ExploreFilter(bookID, "Books"),
  printID: ExploreFilter(printID, "Prints"),
};

var filterRoutes = {
  // /authors
  // /books
  // /categories
  // /classes
  // /collections
  // /editors
  // /prints
  // /roles
  // /series
  0: [
    authorID,
    bookID,
    categoryID,
    classID,
    collectionID,
    editorID,
    printID,
    roleID,
    seriesID
  ],
  // /authors/:author_id/categories
  // /authors/:author_id/classes
  // /authors/:author_id/roles
  // /authors/:author_id/series
  authorID: [categoryID, classID, roleID, seriesID],
  // /authors/:author_id/categories/:category_id/series
  authorID | categoryID: [seriesID],
  // /authors/:author_id/classes/:class_id/series
  authorID | classID: [seriesID],
  // /authors/:author_id/roles/:role_id/series
  authorID | roleID: [seriesID],

  // /categories/:category_id/authors
  // /categories/:category_id/classes
  // /categories/:category_id/series
  categoryID: [authorID, classID, seriesID],
  // /categories/:category_id/classes/:class_id/series
  // /classes/:class_id/categories/:category_id/series
  categoryID | classID: [seriesID],

  // /classes/:class_id/categories
  // /classes/:class_id/series
  classID: [categoryID, seriesID],

  // /collections/:collection_id/books
  // /collections/:collection_id/prints
  // /collections/:collection_id/series
  collectionID: [bookID, printID, seriesID],

  // /editors/:editor_id/collections/:collection_id/books
  // /editors/:editor_id/collections/:collection_id/prints
  // /editors/:editor_id/collections/:collection_id/series
  collectionID | editorID: [bookID, printID, seriesID],

  // /editors/:editor_id/collections/:collection_id/prints/:print_id/books
  // /editors/:editor_id/prints/:print_id/collections/:collection_id/books
  // /prints/:print_id/editors/:editor_id/collections/:collection_id/books
  // /editors/:editor_id/collections/:collection_id/prints/:print_id/series
  // /editors/:editor_id/prints/:print_id/collections/:collection_id/series
  // /prints/:print_id/editors/:editor_id/collections/:collection_id/series
  collectionID | editorID | printID: [bookID, seriesID],

  // /editors/:editor_id/collections/:collection_id/series/:series_id/books
  // /editors/:editor_id/series/:series_id/collections/:collection_id/books
  // /series/:series_id/editors/:editor_id/collections/:collection_id/books
  // /editors/:editor_id/collections/:collection_id/series/:series_id/prints
  // /editors/:editor_id/series/:series_id/collections/:collection_id/prints
  // /series/:series_id/editors/:editor_id/collections/:collection_id/prints
  collectionID | editorID | seriesID: [bookID, printID],

  // /editors/:editor_id/collections/:collection_id/prints/:print_id/series/:series_id/books
  // /editors/:editor_id/collections/:collection_id/series/:series_id/prints/:print_id/books
  // /editors/:editor_id/prints/:print_id/collections/:collection_id/series/:series_id/books
  // /editors/:editor_id/prints/:print_id/series/:series_id/collections/:collection_id/books
  // /editors/:editor_id/series/:series_id/collections/:collection_id/prints/:print_id/books
  // /editors/:editor_id/series/:series_id/prints/:print_id/collections/:collection_id/books
  // /prints/:print_id/editors/:editor_id/collections/:collection_id/series/:series_id/books
  // /prints/:print_id/editors/:editor_id/series/:series_id/collections/:collection_id/books
  // /prints/:print_id/series/:series_id/collections/:collection_id/editors/:editor_id/books
  // /prints/:print_id/series/:series_id/editors/:editor_id/collections/:collection_id/books
  // /series/:series_id/editors/:editor_id/collections/:collection_id/prints/:print_id/books
  // /series/:series_id/editors/:editor_id/prints/:print_id/collections/:collection_id/books
  // /series/:series_id/prints/:print_id/editors/:editor_id/collections/:collection_id/books
  collectionID | editorID | seriesID | printID: [bookID],

  // /collections/:collection_id/prints/:print_id/books
  // /collections/:collection_id/prints/:print_id/series
  collectionID | printID: [bookID, seriesID],

  // /collections/:collection_id/prints/:print_id/series/:series_id/books
  // /collections/:collection_id/series/:series_id/prints/:print_id/books
  // /prints/:print_id/collections/:collection_id/series/:series_id/books
  // /prints/:print_id/series/:series_id/collections/:collection_id/books
  // /series/:series_id/collections/:collection_id/prints/:print_id/books
  collectionID | printID | seriesID: [bookID],

  // /collections/:collection_id/series/:series_id/books
  // /collections/:collection_id/series/:series_id/prints
  // /series/:series_id/collections/:collection_id/books
  // /series/:series_id/collections/:collection_id/prints
  collectionID | seriesID: [bookID, printID],

  // /editors/:editor_id/books
  // /editors/:editor_id/collections
  // /editors/:editor_id/prints
  // /editors/:editor_id/series
  editorID: [bookID, collectionID, printID, seriesID],

  // /editors/:editor_id/prints/:print_id/books
  // /editors/:editor_id/prints/:print_id/collections
  // /editors/:editor_id/prints/:print_id/series
  // /prints/:print_id/editors/:editor_id/books
  // /prints/:print_id/editors/:editor_id/collections
  // /prints/:print_id/editors/:editor_id/series
  editorID | printID: [bookID, collectionID, seriesID],

  // /editors/:editor_id/prints/:print_id/series/:series_id/books
  // /editors/:editor_id/series/:series_id/prints/:print_id/books
  // /prints/:print_id/editors/:editor_id/series/:series_id/books
  // /prints/:print_id/series/:series_id/editors/:editor_id/books
  // /series/:series_id/editors/:editor_id/prints/:print_id/books
  // /series/:series_id/prints/:print_id/editors/:editor_id/books
  // /editors/:editor_id/prints/:print_id/series/:series_id/collections
  // /editors/:editor_id/series/:series_id/prints/:print_id/collections
  // /prints/:print_id/editors/:editor_id/series/:series_id/collections
  // /prints/:print_id/series/:series_id/editors/:editor_id/collections
  // /series/:series_id/editors/:editor_id/prints/:print_id/collections
  // /series/:series_id/prints/:print_id/editors/:editor_id/collections

  editorID | printID | seriesID: [
    bookID,
    collectionID,
  ],

  // /editors/:editor_id/series/:series_id/books
  // /series/:series_id/editors/:editor_id/books
  // /editors/:editor_id/series/:series_id/collections
  // /series/:series_id/editors/:editor_id/collections
  // /editors/:editor_id/series/:series_id/prints
  // /series/:series_id/editors/:editor_id/prints
  editorID | seriesID: [bookID, collectionID, printID],

  // /prints/:print_id/books
  // /prints/:print_id/collections
  // /prints/:print_id/editors
  // /prints/:print_id/series
  printID: [bookID, collectionID, editorID, seriesID],

  // /prints/:print_id/collections/:collection_id/books
  // /prints/:print_id/collections/:collection_id/series
  printID | collectionID: [bookID, seriesID],

// /prints/:print_id/series/:series_id/books
// /series/:series_id/prints/:print_id/books
// /prints/:print_id/series/:series_id/collections
// /series/:series_id/prints/:print_id/collections
// /prints/:print_id/series/:series_id/editors
// /series/:series_id/prints/:print_id/editors
  printID | seriesID: [bookID, collectionID, editorID],

// /roles/:role_id/authors
  roleID: [authorID],

// /roles/:role_id/authors/:author_id/series
  roleID | authorID: [seriesID],

  // /series/:series_id/books
  // /series/:series_id/collections
  // /series/:series_id/editors
  // /series/:series_id/prints
  // /series/:series_id/classifications
  seriesID: [bookID, classID, collectionID, editorID, printID],
};
