import 'package:flutter/material.dart';
import 'scaffold.dart';
import '../utils.dart';

Widget getBottomnavScaffold({
  @required BuildContext context,
  @required GlobalKey<ScaffoldState> scaffoldKey,
  @required Widget body,
  @required int currentIndex,
  @required void Function(int index) onItemTapped,
}) {
  return getScaffold(
    context: context,
    scaffoldKey: scaffoldKey,
    body: body,
    bottom: BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          title: Text('Explore'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          title: Text('Scan'),
        ),
      ],
      currentIndex: currentIndex,
      fixedColor: myPrimarySwatch.shade300,
      onTap: onItemTapped,
    ),
  );
}
