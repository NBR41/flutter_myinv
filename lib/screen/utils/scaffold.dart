import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart' as crypto;
import '../utils.dart';

final _auth = servFactory.getAuthStateProvider();

String _getEmailHash(String email) {
  return hex.encode(crypto.md5
      .convert(Utf8Encoder().convert(email.trim().toLowerCase()))
      .bytes);
}

String getUserIcon(String email) {
  return "https://www.gravatar.com/avatar/" + _getEmailHash(email);
}

Widget getScaffold({
  @required BuildContext context,
  @required GlobalKey<ScaffoldState> scaffoldKey,
  @required Widget body,
  Widget bottom,
}) {
  return new Scaffold(
    key: scaffoldKey,
    appBar: new AppBar(
      title: const Text(TITLE),
      actions: <Widget>[
        GestureDetector(
          onTap: () => scaffoldKey.currentState.openEndDrawer(),
          child: CircleAvatar(
            backgroundImage: NetworkImage(getUserIcon("bernard.fab@gmail.com")),
            radius: 29.0,
          ),
        ),
      ],
    ),
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
                    Text(_auth.token.user.nickname),
                  ],
                ),
                Text(_auth.token.user.email),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.clear,
              color: myColorRed,
            ),
            title: Text('Logout'),
            onTap: () async {
              await _auth.logout();
              Navigator.pop(context);
              Navigator.of(context).pushReplacementNamed("/login");
            },
          ),
        ],
      ),
    ),
    body: body,
    bottomNavigationBar: bottom,
  );
}
