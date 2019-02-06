import 'editor.dart';
import '../screen/home/explore/filters/filters.dart';

class Collection implements DynamicFilter {
  final num id;
  final String name;
  final String href;
  final num editorID;
  final Editor editor;

  Collection(this.id, this.name, this.editorID, [this.href, this.editor]);

  int getID() => id;

  String getFullName() =>
      (editor != null) ? editor.getName() + " - " + name : name;
  String getName() => name;

  Collection.fromJson(Map<String, dynamic> json)
      : id = json['role_id'],
        name = json['role_name'],
        href = json['href'],
        editorID = json['editor_id'],
        editor = Editor.fromJson(json['editor']);

  Map<String, dynamic> toJson() => {
        'collection_id': id,
        'collection_name': name,
        'editor_id': editorID,
      };
}
