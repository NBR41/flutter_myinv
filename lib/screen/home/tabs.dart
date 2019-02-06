import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../service/factory.dart';
import 'explore/home.dart';
import 'scanner.dart';
import 'tab_page.dart';

typedef PageCreator = Page Function(Widget body);

class CustomTab extends StatefulWidget {
  final Widget child;

  CustomTab({Key key, @required this.child}) : super(key: key);

  @override
  _CustomTabState createState() => _CustomTabState();
}

class _CustomTabState extends State<CustomTab> {
  BuildContext tabContext;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabView(
      builder: (BuildContext context) {
        tabContext = context;
        return widget.child;
      },
    );
  }
}

class Tabbed extends StatefulWidget {
  final PageCreator createPage;
  final Modeler modeler;

  Tabbed({Key key, @required this.createPage, @required this.modeler})
      : super(key: key);

  @override
  _TabbedState createState() => _TabbedState(createPage, modeler);
}

class _TabbedState extends State<Tabbed> {
  int _currentTab = 0;
  List<GlobalKey<_CustomTabState>> _keys;
  List<CustomTab> tabs;

  _TabbedState(PageCreator createPage, Modeler modeler) {
    _keys = [
      new GlobalKey<_CustomTabState>(),
      new GlobalKey<_CustomTabState>(),
      new GlobalKey<_CustomTabState>()
    ];
    tabs = <CustomTab>[
      CustomTab(
        key: _keys[0],
        child: Center(child: Text('Home')),
      ),
      CustomTab(
        child:
            createPage(ExplorePage(createPage: createPage, modeler: modeler)),
      ),
      CustomTab(
        child: createPage(ScannerPage()),
      ),
    ];
  }

  Future<Null> _setTab(int index) async {
    if (_currentTab == index) {
      if (Navigator.of(_keys[index].currentState.tabContext).canPop()) {
        Navigator.of(_keys[index].currentState.tabContext)
            .popUntil((Route<dynamic> r) => r.isFirst);
      }
      return;
    }
    setState(() {
      _currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Stack(
          children: <Widget>[
            _buildStack(),
            _buildTabs(),
          ],
        ),
      ),
    );
  }

  Widget _buildStack() {
    return Container(
      child: IndexedStack(
        sizing: StackFit.expand,
        index: _currentTab,
        children: tabs,
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      child: Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              border: Border(
                top: BorderSide(color: Color.fromRGBO(58, 66, 86, 0.3)),
              ),
            ),
            height: 55.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  iconSize: 30.0,
                  color: _currentTab == 0
                      ? Color.fromRGBO(58, 66, 86, 1.0)
                      : Color.fromRGBO(58, 66, 86, 0.3),
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    _setTab(0);
                  },
                ),
                IconButton(
                  iconSize: 30.0,
                  color: _currentTab == 1
                      ? Color.fromRGBO(58, 66, 86, 1.0)
                      : Color.fromRGBO(58, 66, 86, 0.3),
                  icon: const Icon(Icons.list),
                  onPressed: () {
                    _setTab(1);
                  },
                ),
                IconButton(
                  iconSize: 30.0,
                  color: _currentTab == 2
                      ? Color.fromRGBO(58, 66, 86, 1.0)
                      : Color.fromRGBO(58, 66, 86, 0.3),
                  icon: const Icon(Icons.notifications),
                  onPressed: () {
                    _setTab(2);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
