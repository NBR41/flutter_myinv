import 'user.dart';

class AuthToken {
  User user;
  String accessToken;
  String refreshToken;

  AuthToken(this.user, this.accessToken, this.refreshToken);

  AuthToken.fromJson(Map<String, dynamic> json)
      : user = User.fromJson(json['user']),
        accessToken = json['access_token'],
        refreshToken = json['refresh_token'];

  Map<String, dynamic> toJson() => {
        'user': user?.toJson(),
        'access_token': accessToken,
        'refresh_token': refreshToken,
      };
}
