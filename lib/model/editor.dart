class Editor {
  final num id;
  final String name;
  final String href;

  Editor(this.id, this.name, this.href);

  Editor.fromJson(Map<String, dynamic> json)
      : id = json['editor_id'],
        name = json['editor_name'],
        href = json['href'];

  Map<String, dynamic> toJson() => {
        'editor_id': id,
        'editor_name': name,
      };
}
