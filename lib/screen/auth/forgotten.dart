import 'dart:ui';
import 'package:flutter/material.dart';
import '../../service/factory.dart';
import '../utils.dart';
import 'utils.dart';

class ForgottenScreen extends StatefulWidget {
  final UserService userServ;

  ForgottenScreen(this.userServ);

  @override
  _ForgottenScreenState createState() => _ForgottenScreenState();
}

class _ForgottenScreenState extends State<ForgottenScreen> {
  GlobalKey<FormState> _formKey;
  GlobalKey<ScaffoldState> _scaffoldKey;
  FocusNode _emailNode;
  String _email;
  bool _isLoading = false;
  bool _autoValidate;

  @override
  void initState() {
    super.initState();
    _formKey = new GlobalKey<FormState>();
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    _emailNode = FocusNode();
    _autoValidate = false;
  }

  @override
  void dispose() {
    _emailNode.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) async {
    final form = _formKey.currentState;

    if (form.validate()) {
      setState(() {
        _autoValidate = false;
        _isLoading = true;
      });
      form.save();
      try {
        await widget.userServ.requestResetPassword(_email);
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute<void>(builder: (BuildContext context) {
          return ForgottenMailScreen();
        }));
      } catch (error) {
        _scaffoldKey.currentState
            .showSnackBar(new SnackBar(content: new Text(error.toString())));
      }

      setState(() => _isLoading = false);
    } else {
      setState(() => _autoValidate = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    var _buttons = Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      ButtonTheme(
        minWidth: 75.0,
        child: new RaisedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: new Text(
            "Back",
            style: TextStyle(color: Colors.black, fontSize: 20.0),
          ),
          color: Colors.grey,
        ),
      ),
      ButtonTheme(
        minWidth: 75.0,
        child: new RaisedButton(
          onPressed: () {
            _submit(context);
          },
          child: new Text(
            "RESET",
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          color: myColorGreen,
        ),
      ),
    ]);

    return getAuthScaffold(
      height: 400,
      scaffoldKey: _scaffoldKey,
      form: [
        new Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: new Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: getTextFormField(
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  focusNode: _emailNode,
                  onFieldSubmitted: (term) {
                    _emailNode.unfocus();
                    _submit(context);
                  },
                  onSaved: (val) => _email = val,
                  validator: validateEmail,
                  labelText: "Email",
                  hintText: "Your Email",
                ),
              ),
            ],
          ),
        ),
        _isLoading
            ? Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                padding: EdgeInsets.all(15),
              )
            : _buttons,
      ],
    );
  }
}

class ForgottenMailScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return getAuthScaffold(
      height: 400,
      scaffoldKey: null,
      form: [
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.mail, size: 200, color: myColorGreen),
              Container(
                margin: EdgeInsets.all(5.0),
                child: Text(
                  "A mail to reset your password has been sent to your mailbox.\n",
                  style: MYSTYLEBIGBOLDWHITE,
                ),
              ),
              ButtonTheme(
                minWidth: 75.0,
                child: new RaisedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: new Text(
                    "BACK",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  color: myColorGreen,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
