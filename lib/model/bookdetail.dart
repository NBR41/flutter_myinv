class BookDetail {
  final String name;
  final String volume;
  final String category;
  final String description;
  final String editor;
  final String author;
  final String imageURL;

  BookDetail(
    this.name,
    this.volume,
    this.category,
    this.description,
    this.editor,
    this.author,
    this.imageURL,
  );

  BookDetail.fromJson(Map<String, dynamic> json)
      : name = json['title'],
        category =
            (json.containsKey('categories') && json['categories'].length > 0)
                ? json['categories'][0]
                : '',
        volume = (json.containsKey('seriesInfo') &&
                json['seriesInfo'].containsKey('bookDisplayNumber'))
            ? json['seriesInfo']['bookDisplayNumber']
            : '',
        description =
            (json.containsKey('description')) ? json['description'] : '',
        editor = (json.containsKey('publisher')) ? json['publisher'] : '',
        author = (json.containsKey('authors') && json['authors'].length > 0)
            ? json['authors'][0]
            : '',
        imageURL = (json.containsKey('imageLinks') &&
                json['imageLinks'].containsKey('smallThumbnail'))
            ? json['imageLinks']['smallThumbnail']
            : '';

  String getString() {
    return 'name: ' +
        name +
        "\nVolume: " +
        volume +
        "\ncategory: " +
        category +
        "\ndescription: " +
        description +
        "\neditor: " +
        editor +
        "\nauthor: " +
        author +
        "\nimageURL: " +
        imageURL;
  }
}
