import 'package:flutter/material.dart';

import 'screen/skeleton.dart';
import 'screen/auth/login.dart';
import 'service/factory.dart';
import 'screen/utils.dart';

final routes = {
  '/login': (BuildContext context) =>
      new LoginScreen(servFactory.getAuthStateProvider()),
  '/home': (BuildContext context) => SkeletonPage(),
  '/': (BuildContext context) =>
      new LoginScreen(servFactory.getAuthStateProvider()),
};

void main() => runApp(MyApp());

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
