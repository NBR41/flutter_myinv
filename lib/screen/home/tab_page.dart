import 'package:flutter/material.dart';
import '../utils.dart';
import '../../service/auth.dart';

class Page extends StatefulWidget {
  final Widget body;
  final AuthStateProvider auth;

  Page({Key key, @required this.body, @required this.auth}) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(TITLE),
        actions: <Widget>[
          GestureDetector(
            onTap: () => _scaffoldKey.currentState.openEndDrawer(),
            child: CircleAvatar(
              backgroundImage:
                  NetworkImage(getUserIcon("bernard.fab@gmail.com")),
              radius: 29.0,
            ),
          ),
        ],
      ),
      body: widget.body,
      endDrawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the Drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(getUserIcon("bernard.fab@gmail.com")),
                      ),
                      Text(widget.auth.token.user.nickname),
                    ],
                  ),
                  Text(widget.auth.token.user.email),
                ],
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.clear,
                color: Colors.red,
              ),
              title: Text('Logout'),
              onTap: () async {
                await widget.auth.logout();
                Navigator.pop(context);
                Navigator.of(context).pushReplacementNamed("/login");
              },
            ),
          ],
        ),
      ),
    );
  }
}
