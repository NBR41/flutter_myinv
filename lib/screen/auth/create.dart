import 'dart:ui';
import 'package:flutter/material.dart';
import '../../service/factory.dart';
import '../utils.dart';
import 'utils.dart';

class CreateScreen extends StatefulWidget {
  final UserService userServ;

  CreateScreen(this.userServ);

  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  GlobalKey<FormState> _formKey;
  GlobalKey<ScaffoldState> _scaffoldKey;
  FocusNode _emailNode;
  FocusNode _nicknameNode;
  FocusNode _passwordNode;
  String _email, _nickname, _password;
  bool _autoValidate;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _formKey = new GlobalKey<FormState>();
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    _emailNode = FocusNode();
    _nicknameNode = FocusNode();
    _passwordNode = FocusNode();
    _autoValidate = false;
  }

  @override
  void dispose() {
    _emailNode.dispose();
    _nicknameNode.dispose();
    _passwordNode.dispose();
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
        await widget.userServ.create(_email, _nickname, _password);
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute<void>(builder: (BuildContext context) {
          return AccountCreatedScreen();
        }));
      } catch (error) {
        _scaffoldKey.currentState
            .showSnackBar(new SnackBar(content: new Text(error.toString())));
      }

      setState(() => _isLoading = false);
    } else {
      setState(() {
        _autoValidate = true;
      });
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
          child: new Text("Back",
              style: TextStyle(color: Colors.black, fontSize: 20.0)),
          color: Colors.grey,
        ),
      ),
      ButtonTheme(
        minWidth: 75.0,
        child: new RaisedButton(
          onPressed: () {
            _submit(context);
          },
          child: new Text("SIGNUP",
              style: TextStyle(color: Colors.white, fontSize: 20.0)),
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
                  textInputAction: TextInputAction.next,
                  focusNode: _emailNode,
                  onFieldSubmitted: (term) {
                    _emailNode.unfocus();
                    FocusScope.of(context).requestFocus(_nicknameNode);
                  },
                  onSaved: (val) => _email = val,
                  validator: validateEmail,
                  labelText: "Email",
                  hintText: "Your Email",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: getTextFormField(
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  focusNode: _nicknameNode,
                  onFieldSubmitted: (term) {
                    _nicknameNode.unfocus();
                    FocusScope.of(context).requestFocus(_passwordNode);
                  },
                  onSaved: (val) => _nickname = val,
                  validator: (val) =>
                      val.isEmpty ? "Nickname must be defined" : null,
                  labelText: "Nickname",
                  hintText: "Your Nickname",
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: getTextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  focusNode: _passwordNode,
                  onFieldSubmitted: (term) {
                    _passwordNode.unfocus();
                    _submit(context);
                  },
                  onSaved: (val) => _password = val,
                  validator: (val) =>
                      val.isEmpty ? "Password must be defined" : null,
                  labelText: "Password",
                  hintText: "Your Password",
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

class AccountCreatedScreen extends StatelessWidget {
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
              Icon(Icons.info_outline, size: 200, color: myColorGreen),
              Container(
                margin: EdgeInsets.all(5.0),
                child: Text(
                  "Your account has been created.\nWe have sent you an email to activate your account.",
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
