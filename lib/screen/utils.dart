import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart' as crypto;
import '../service/factory.dart';

final servFactory = ServiceFactory('foo');

const TITLE = 'MyInventory';
const BIGGERFONT = TextStyle(fontSize: 18.0);
var mainColor = Colors.purple.shade200.withOpacity(0.5);

String _getEmailHash(String email) {
  return hex.encode(crypto.md5
      .convert(Utf8Encoder().convert(email.trim().toLowerCase()))
      .bytes);
}

String getUserIcon(String email) {
  return "https://www.gravatar.com/avatar/" + _getEmailHash(email);
}

Widget getScaffold(
    {@required BuildContext context,
    @required GlobalKey<ScaffoldState> scaffoldKey,
    @required Widget body,
    Widget bottom}) {
  var auth = servFactory.getAuthStateProvider();
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
                    Text(auth.token.user.nickname),
                  ],
                ),
                Text(auth.token.user.email),
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
              await auth.logout();
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

///
/// Loading screen with custom text
///
class LoadingScreen extends StatelessWidget {
  final String txt;

  const LoadingScreen({Key key, this.txt}) : super(key: key);

  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            child: CircularProgressIndicator(strokeWidth: 6.0),
            height: 100.0,
            width: 100.0,
          ),
          Container(
              margin: EdgeInsets.all(30.0),
              child: Text(
                this.txt,
                style: BIGGERFONT,
              )),
        ],
      ),
    );
  }
}

class WarningScreen extends StatelessWidget {
  final String txt;

  const WarningScreen({Key key, this.txt}) : super(key: key);

  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new LayoutBuilder(builder: (context, constraint) {
            return new Icon(Icons.warning,
                size: constraint.biggest.width, color: mainColor);
          }),
          Container(
              margin: EdgeInsets.all(30.0),
              child: Text(
                this.txt,
                style: BIGGERFONT,
              )),
        ],
      ),
    );
  }
}
