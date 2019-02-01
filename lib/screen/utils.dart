import 'package:flutter/material.dart';

const TITLE = 'MyInventory';
const BIGGERFONT = TextStyle(fontSize: 18.0);

Widget getScaffold({@required Widget body, Widget bottom}) {
  return new Scaffold(
    appBar: new AppBar(title: const Text(TITLE)),
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
                size: constraint.biggest.width, color: Colors.red);
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
