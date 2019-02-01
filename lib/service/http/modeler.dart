import 'dart:async';
import 'dart:convert';

import '../../model/book.dart';
import 'package:http/http.dart' as http;

class ModelerHTTP {
  final String domain;
  String token;

  ModelerHTTP(this.domain);

  void setToken(String token) {
    this.token = token;
  }

  Future<Book> getBook(String isbn) {
    return _getBook('/books/isbn/' + isbn);
  }

  Future<Book> _getBook(String path) async {
    final response = await getURI(path);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return Book.fromJson(json.decode(response.body));
    } else {
      // If that response was not OK, throw an error.
      return Future.error('Failed to load book');
    }
  }

  Future<http.Response> getURI(String path) {
    return http.get(
      domain + path,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + this.token,
      },
    );
  }
}
