import 'dart:ui';
import 'package:flutter/material.dart';
import '../utils.dart';

String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Enter a valid Email';
  else
    return null;
}

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

TextFormField getTextFormField({
  @required TextInputType keyboardType,
  @required bool obscureText,
  @required TextInputAction textInputAction,
  @required FocusNode focusNode,
  @required ValueChanged<String> onFieldSubmitted,
  @required FormFieldSetter<String> onSaved,
  @required FormFieldValidator<String> validator,
  @required String labelText,
  @required String hintText,
}) {
  return TextFormField(
    keyboardType: keyboardType,
    obscureText: obscureText,
    textInputAction: textInputAction,
    focusNode: focusNode,
    onFieldSubmitted: onFieldSubmitted,
    onSaved: onSaved,
    validator: validator,
    style: TextStyle(
      color: myColorYellow,
      fontSize: 18.0,
    ),
    decoration: new InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: myColorBlue),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: myColorBlue),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: myColorOrange),
      ),
      errorStyle: TextStyle(
        color: myColorOrange,
        fontSize: 13.0,
      ),
      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
      hintText: hintText,
    ),
  );
}
