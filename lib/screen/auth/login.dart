import 'dart:ui';

import 'package:flutter/material.dart';
import 'login_presenter.dart';
import 'auth_observable.dart';
import '../utils.dart';
import '../../model/token.dart';
import '../../service/wrapper/auth.dart';
import 'utils.dart';

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

  AuthObservable authObservable;
  LoginScreenPresenter _presenter;

  GlobalKey<FormState> _formKey;
  GlobalKey<ScaffoldState> _scaffoldKey;
  FocusNode _loginNode;
  FocusNode _passwordNode;

  String _username, _password;
  bool _isLoading = false;
  bool _autoValidate;

  LoginScreenState(AuthStateProvider auth) {
    _presenter = LoginScreenPresenter(this, auth);
    authObservable = new AuthObservable(auth);
    authObservable.subscribe(this);
  }

  @override
  void initState() {
    super.initState();
    _formKey = new GlobalKey<FormState>();
    _scaffoldKey = new GlobalKey<ScaffoldState>();
    _loginNode = FocusNode();
    _passwordNode = FocusNode();
    _autoValidate = false;
  }

  @override
  void dispose() {
    _loginNode.dispose();
    _passwordNode.dispose();
    super.dispose();
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
    final form = _formKey.currentState;
    if (form.validate()) {
      setState(() {
        _autoValidate = false;
        _isLoading = true;
      });
      form.save();
      _presenter.doLogin(_username, _password);
    } else {
      setState(() => _autoValidate = true);
    }
  }

  void goToCreate() {
    Navigator.of(_ctx).pushNamed("/create");
  }

  void goToForgotten() {
    Navigator.of(_ctx).pushNamed("/forgotten");
  }

  void _showSnackBar(String text) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    return getAuthScaffold(height: 410, scaffoldKey: _scaffoldKey, form: [
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
                focusNode: _loginNode,
                onFieldSubmitted: (term) {
                  _loginNode.unfocus();
                  FocusScope.of(context).requestFocus(_passwordNode);
                },
                onSaved: (val) => _username = val,
                validator: (val) =>
                    val.isEmpty ? "Login must be defined" : null,
                labelText: "Login",
                hintText: "Your Email or Nickname",
              ),
            ),
            getTextFormField(
              obscureText: true,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              focusNode: _passwordNode,
              onFieldSubmitted: (term) {
                _passwordNode.unfocus();
                _submit();
              },
              onSaved: (val) => _password = val,
              validator: (val) =>
                  val.isEmpty ? "Password must be defined" : null,
              labelText: "Password",
              hintText: "Your Password",
            ),
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: _isLoading ? null : goToForgotten,
          child: Text("FORGOTTEN PASSWORD ?",
              style: TextStyle(
                  color: myColorBlue,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold)),
        ),
      ),
      Center(
        child: ButtonTheme(
          minWidth: 150.0,
          child: new RaisedButton(
            onPressed: _submit,
            child: new Text("LOGIN",
                style: TextStyle(color: Colors.white, fontSize: 20.0)),
            color: myColorGreen,
          ),
        ),
      ),
      Divider(),
      Text(
        "Don't already have an account ?",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      Center(
          child: RaisedButton(
        onPressed: _isLoading ? null : goToCreate,
        child: new Text("SIGNUP",
            style: TextStyle(color: Colors.white, fontSize: 12.0)),
        color: myColorYellow,
      )),
    ]);
  }
}
