import 'dart:async';
import 'dart:convert';

import '../model/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  static const authKey = 'auth_token';

  static final StorageHelper _instance = new StorageHelper.internal();
  factory StorageHelper() => _instance;

  static SharedPreferences _db;

  Future<SharedPreferences> get db async {
    if (_db != null) return _db;
    _db = await SharedPreferences.getInstance();
    return _db;
  }

  StorageHelper.internal();

  Future<bool> save(AuthToken token) async {
    var dbClient = await db;
    return await dbClient.setString(authKey, jsonEncode(token.toJson()));
  }

  Future<bool> delete() async {
    var dbClient = await db;
    return await dbClient.remove(authKey);
  }

  Future<AuthToken> get() async {
    try {
      var dbClient = await db;
      var val = dbClient.getString(authKey) ?? '';
      if (val.isEmpty == false) {
        return Future.value(AuthToken.fromJson(jsonDecode(val)));
      }
    } catch (e) {
      return Future.error(e.toString());
    }
    return Future.value(null);
  }
}
