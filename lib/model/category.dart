import '../screen/home/explore/filters/filters.dart';

class Category implements DynamicFilter {
  final num id;
  final String name;
  final String href;

  Category(this.id, this.name, [this.href]);

  int getID() => id;

  String getFullName() => name;
  String getName() => name;

  Category.fromJson(Map<String, dynamic> json)
      : id = json['category_id'],
        name = json['category_name'],
        href = json['href'];

  Map<String, dynamic> toJson() => {
        'category_id': id,
        'category_name': name,
      };
}
