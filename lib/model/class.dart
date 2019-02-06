import '../screen/home/explore/filters/filters.dart';

class Class implements DynamicFilter {
  final num id;
  final String name;
  final String href;

  Class(this.id, this.name, [this.href]);

  int getID() => id;

  String getFullName() => name;
  String getName() => name;

  Class.fromJson(Map<String, dynamic> json)
      : id = json['class_id'],
        name = json['class_name'],
        href = json['href'];

  Map<String, dynamic> toJson() => {
        'class_id': id,
        'class_name': name,
      };
}
