import 'package:flutter/material.dart';

import 'screen/home/tabs.dart';
import 'screen/home/tab_page.dart';
import 'screen/auth/login.dart';
import 'service/factory.dart';
import 'screen/utils.dart';

//import 'package:flutter/rendering.dart';

final routes = {
  '/login': (BuildContext context) =>
      new LoginScreen(servFactory.getAuthStateProvider()),
  '/home': (BuildContext context) => Tabbed(
        createPage: (Widget body) =>
            Page(body: body, auth: servFactory.getAuthStateProvider()),
        modeler: servFactory.getModeler(),
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
      : servFactory = ServiceFactory(domain),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: TITLE,
      theme: new ThemeData(
        primarySwatch: Colors.purple,
      ),
      routes: routes,
    );
  }
}
