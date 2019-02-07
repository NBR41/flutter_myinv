import 'package:flutter/material.dart';
import '../utils/bottom_nav_scaffold.dart';
import 'scanner.dart';

typedef PageCreator = HomePage Function(Widget body);

class HomePage extends StatefulWidget {
  final int selectedIndex;
  final Widget explorePage;

  HomePage({Key key, @required this.selectedIndex, this.explorePage})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(selectedIndex);
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _selectedIndex;

  _HomePageState(int index) {
    _selectedIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return getBottomnavScaffold(
      context: context,
      scaffoldKey: _scaffoldKey,
      body: Center(child: _getBottomMenuScreen(_selectedIndex)),
      currentIndex: _selectedIndex,
      onItemTapped: _onItemTapped,
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
        return widget.explorePage;
        break;
      case 2:
        return ScannerPage();
        break;
      default:
        return Center(child: Text('Home'));
        break;
    }
  }
}
