import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils.dart';

Widget getAuthScaffold(
    {@required double height,
    @required GlobalKey<ScaffoldState> scaffoldKey,
    @required List<Widget> form}) {
  var col = Column(
    children: <Widget>[
      Center(
        child: new Text(
          "MyInventory",
          textScaleFactor: 2.0,
          style: TextStyle(color: Colors.white),
        ),
      ),
    ],
    crossAxisAlignment: CrossAxisAlignment.start,
  );
  col.children.addAll(form);
  return new Scaffold(
    appBar: null,
    resizeToAvoidBottomPadding: false,
    key: scaffoldKey,
    backgroundColor: myColorBlue,
    body: new Container(
      child: new Center(
        child: new ClipRect(
          child: new BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: new Container(
              child: col,
              height: height,
              width: 300.0,
              padding: EdgeInsets.all(8),
              decoration: new BoxDecoration(
                  color: Colors.grey.shade200.withOpacity(0.5)),
            ),
          ),
        ),
      ),
    ),
  );
}
