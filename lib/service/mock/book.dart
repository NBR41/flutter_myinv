import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../model/bookdetail.dart';
import '../factory.dart';

class MockBook implements BookService {
  //https://www.googleapis.com/books/v1/volumes?projection=full&q=isbn:9782331040139
  static const String baseURL =
      'https://www.googleapis.com/books/v1/volumes?projection=full&q=isbn:';

  Future<BookDetail> getByISBN(String isbn) async {
    //print(baseURL + '9782331040139');
    //isbn = '9782331040139';
    //isbn = '9782723428262';
    final response = await http.get(baseURL + isbn);

    if (response.statusCode == 200) {
      var val = json.decode(response.body);
      if (val.containsKey('items') &&
          val['items'].length > 0 &&
          val['items'][0].containsKey('volumeInfo')) {
        // If the call to the server was successful, parse the JSON
        return BookDetail.fromJson(val['items'][0]['volumeInfo']);
      } else {
        return Future.error("no book found");
      }
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
