import 'package:flutter/material.dart';

import 'screen/home/home.dart';
import 'screen/home/scanner.dart';
import 'screen/home/explore/home.dart';
import 'screen/auth/create.dart';
import 'screen/auth/forgotten.dart';
import 'screen/auth/login.dart';

import 'service/factory.dart';
import 'screen/utils.dart';

//import 'package:flutter/rendering.dart';

var scanner = ScannerPage(bookServ: servFactory.getBookService());

final routes = {
  '/login': (BuildContext context) =>
      new LoginScreen(servFactory.getAuthStateProvider()),
  '/create': (BuildContext context) =>
      new CreateScreen(servFactory.getUserService()),
  '/forgotten': (BuildContext context) =>
      new ForgottenScreen(servFactory.getUserService()),
  '/validate': (BuildContext context) =>
      new LoginScreen(servFactory.getAuthStateProvider()),
  '/home': (BuildContext context) => HomePage(
        selectedIndex: 0,
        scannerPage: scanner,
        explorePage: ExploreHomePage(
          modelServ: servFactory.getModelService(),
          createPage: (Widget body) => HomePage(
                selectedIndex: 1,
                scannerPage: scanner,
                explorePage: body,
              ),
        ),
      ),
  '/': (BuildContext context) =>
      new LoginScreen(servFactory.getAuthStateProvider()),
};

void main() {
  //debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ServiceFactory servFactory;

  MyApp({Key key, String domain})
      : servFactory = ServiceFactory(domain: domain),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: TITLE,
      theme: new ThemeData(
        primarySwatch: myPrimarySwatch,
      ),
      routes: routes,
    );
  }
}
