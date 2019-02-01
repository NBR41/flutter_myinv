import 'category.dart';

class Series {
  final num id;
  final String name;
  final String href;
  final num categoryID;
  final Category category;

  Series(this.id, this.name, this.categoryID, [this.href, this.category]);

  Series.fromJson(Map<String, dynamic> json)
      : id = json['series_id'],
        name = json['series_name'],
        href = json['href'],
        categoryID = json['category_id'],
        category = Category.fromJson(json['category']);

  Map<String, dynamic> toJson() => {
        'series_id': id,
        'series_name': name,
        'category_id': categoryID,
      };
}
