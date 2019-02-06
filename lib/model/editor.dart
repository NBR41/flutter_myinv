import '../screen/home/explore/filters/filters.dart';

class Editor implements DynamicFilter {
  final num id;
  final String name;
  final String href;

  Editor(this.id, this.name, [this.href]);

  int getID() => id;

  String getFullName() => name;
  String getName() => name;

  Editor.fromJson(Map<String, dynamic> json)
      : id = json['editor_id'],
        name = json['editor_name'],
        href = json['href'];

  Map<String, dynamic> toJson() => {
        'editor_id': id,
        'editor_name': name,
      };
}
