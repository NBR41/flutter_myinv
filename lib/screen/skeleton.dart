/*
import 'package:flutter/material.dart';

import 'home/explore/home.dart';
import 'utils.dart';
import 'home/scanner.dart';

class SkeletonPage extends StatefulWidget {
  SkeletonPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SkeletonPageState createState() => _SkeletonPageState();
}

class _SkeletonPageState extends State<SkeletonPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;
  final _widgetOptions = [
    Text('Home'),
    Text('Explore'),
    Text('Scan'),
  ];

  @override
  Widget build(BuildContext context) {
    return getScaffold(
      context: context,
      scaffoldKey: _scaffoldKey,
      body: Center(child: _getBottomMenuScreen(_selectedIndex)),
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
        currentIndex: _selectedIndex,
        fixedColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getBottomMenuScreen(int index) {
    switch (index) {
      case 1:
        return ExplorePage(modeler: servFactory.getModeler());
        break;
      case 2:
        return ScannerPage();
        break;
      default:
        return Center(child: _widgetOptions.elementAt(_selectedIndex));
        break;
    }
  }
}
*/
