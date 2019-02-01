class Class {
  final num id;
  final String name;
  final String href;

  Class(this.id, this.name, this.href);

  Class.fromJson(Map<String, dynamic> json)
      : id = json['class_id'],
        name = json['class_name'],
        href = json['href'];

  Map<String, dynamic> toJson() => {
        'class_id': id,
        'class_name': name,
      };
}
