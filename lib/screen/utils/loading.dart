import 'package:flutter/material.dart';
import '../utils.dart';

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
            child: CircularProgressIndicator(
              strokeWidth: 6.0,
              valueColor: AlwaysStoppedAnimation<Color>(myColorBlue),
            ),
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
