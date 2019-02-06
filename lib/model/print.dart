import '../screen/home/explore/filters/filters.dart';

class Print implements DynamicFilter {
  final num id;
  final String name;
  final String href;

  Print(this.id, this.name, [this.href]);

  int getID() => id;

  String getFullName() => name;
  String getName() => name;

  Print.fromJson(Map<String, dynamic> json)
      : id = json['print_id'],
        name = json['print_name'],
        href = json['href'];

  Map<String, dynamic> toJson() => {
        'print_id': id,
        'print_name': name,
      };
}
