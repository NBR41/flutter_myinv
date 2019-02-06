import '../screen/home/explore/filters/filters.dart';

class Author implements DynamicFilter {
  final int id;
  final String name;
  final String href;

  Author(this.id, this.name, [this.href]);

  int getID() => id;

  String getName() => name;
  String getFullName() => name;

  Author.fromJson(Map<String, dynamic> json)
      : id = json['author_id'],
        name = json['author_name'],
        href = json['href'];

  Map<String, dynamic> toJson() => {
        'author_id': id,
        'author_name': name,
      };
}
