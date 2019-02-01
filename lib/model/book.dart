import 'series.dart';

class Book {
  final num id;
  final String isbn;
  final String name;
  final String href;
  final num seriesID;
  final Series series;

  Book(this.id, this.isbn, this.name, this.seriesID, [this.href, this.series]);

  Book.fromJson(Map<String, dynamic> json)
      : id = json['book_id'],
        isbn = json['book_isbn'],
        name = json['book_name'],
        href = json['href'],
        seriesID = json['series_id'],
        series = Series.fromJson(json['series']);

  Map<String, dynamic> toJson() => {
        'book_id': id,
        'book_isbn': isbn,
        'book_name': name,
        'series_id': seriesID,
      };
}
