class Role {
  final num id;
  final String name;
  final String href;

  Role(this.id, this.name, this.href);

  Role.fromJson(Map<String, dynamic> json)
      : id = json['role_id'],
        name = json['role_name'],
        href = json['href'];

  Map<String, dynamic> toJson() => {
        'role_id': id,
        'role_name': name,
      };
}
