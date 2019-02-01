class Author {
  final num id;
  final String name;
  final String href;

  Author(this.id, this.name, this.href);

  Author.fromJson(Map<String, dynamic> json)
      : id = json['author_id'],
        name = json['author_name'],
        href = json['href'];

  Map<String, dynamic> toJson() => {
        'author_id': id,
        'author_name': name,
      };
}
