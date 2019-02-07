import 'package:flutter/material.dart';
import '../utils.dart';

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
                size: constraint.biggest.width, color: myColorOrange);
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
