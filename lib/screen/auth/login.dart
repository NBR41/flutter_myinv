import 'dart:ui';

import 'package:flutter/material.dart';
import 'login_presenter.dart';
import 'auth_observable.dart';
import '../utils.dart';
import '../../model/token.dart';
import '../../service/auth.dart';

class LoginScreen extends StatefulWidget {
  final AuthStateProvider auth;

  LoginScreen(this.auth);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LoginScreenState(auth);
  }
}

class LoginScreenState extends State<LoginScreen>
    implements LoginScreenContract, AuthObserver {
  BuildContext _ctx;

  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  AuthObservable authObservable;

  bool _isLoading = false;
  String _username, _password;

  LoginScreenPresenter _presenter;

  LoginScreenState(AuthStateProvider auth) {
    _presenter = LoginScreenPresenter(this, auth);
    authObservable = new AuthObservable(auth);
    authObservable.subscribe(this);
  }

  @override
  onAuthStateChanged(AuthState state) {
    if (state == AuthState.LOGGED_IN) {
      Navigator.of(_ctx).pushReplacementNamed("/home");
    }
  }

  @override
  void onLoginError(String errorTxt) {
    _showSnackBar(errorTxt);
    setState(() => _isLoading = false);
  }

  @override
  void onLoginSuccess(AuthToken token) async {
    _showSnackBar(token?.user.toString());
    setState(() => _isLoading = false);
    authObservable.notify(AuthState.LOGGED_IN);
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() => _isLoading = true);
      form.save();
      _presenter.doLogin(_username, _password);
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = new RaisedButton(
      onPressed: _submit,
      child: new Text("LOGIN", style: TextStyle(color: Colors.white)),
      color: myColorGreen,
    );
    var loginForm = new Column(
      children: <Widget>[
        new Text(
          "MyInventory",
          textScaleFactor: 2.0,
          style: TextStyle(color: Colors.white),
        ),
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  onSaved: (val) => _username = val,
                  validator: (val) {
                    return val.isEmpty
                        ? "Username must have atleast 10 chars"
                        : null;
                  },
                  decoration: new InputDecoration(
                      labelText: "Username",
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      )),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  onSaved: (val) => _password = val,
                  decoration: new InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      )),
                ),
              ),
            ],
          ),
        ),
        _isLoading ? new CircularProgressIndicator() : loginBtn
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
    );

    return new Scaffold(
      appBar: null,
      key: scaffoldKey,
      backgroundColor: myColorBlue,
      body: new Container(
        child: new Center(
          child: new ClipRect(
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: new Container(
                child: loginForm,
                height: 300.0,
                width: 300.0,
                decoration: new BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(0.5)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
