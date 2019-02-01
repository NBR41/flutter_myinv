class User {
  num id;
  String email;
  String nickname;
  bool isAdmin;
  bool isValidated;
  String href;

  User(this.id, this.email, this.nickname,
      [this.isAdmin, this.isValidated, this.href]);

  User.fromJson(Map<String, dynamic> json)
      : id = json['user_id'],
        email = json['email'],
        nickname = json['nickname'],
        isAdmin = json['is_admin'],
        isValidated = json['is_validated'],
        href = json['href'];

  Map<String, dynamic> toJson() => {
        'user_id': id,
        'email': email,
        'nickname': nickname,
        'is_admin': isAdmin,
        'is_validated': isValidated,
      };
}
