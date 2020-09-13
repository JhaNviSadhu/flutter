import 'package:flutter/material.dart';
import 'Auth/login.dart';
import '../AuthService/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home/home.dart';
//import 'package:firebase_core/firebase_core.dart';

class WidgetTree extends StatefulWidget {
  final AuthAction authAction;
  WidgetTree({@required this.authAction});
  @override
  _WidgetTreeState createState() => _WidgetTreeState();
}

enum AuthResult {
  isLogin,
  isNotLogin,
}

class _WidgetTreeState extends State<WidgetTree> {
  User user;
  AuthResult authResult = AuthResult.isNotLogin;
  @override
  void initState() {
    try {
      widget.authAction.currentUser().then((currUser) {
        setState(() {
          user = currUser;
          authResult =
              user != null ? AuthResult.isLogin : AuthResult.isNotLogin;
        });
      });
    } catch (e) {
      print(e);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (authResult) {
      case AuthResult.isNotLogin:
        return LoginScreen(
          createuser: (email, password) async {
            await widget.authAction
                .createUser(email, password)
                .then((currUser) {
              if (currUser != null) {
                user = currUser;
                authResult = AuthResult.isLogin;
                setState(() {});
              }
              return null;
            });
          },
          singInUser: (email, password) async {
            await widget.authAction
                .singInUser(email, password)
                .then((currUser) {
              if (currUser != null) {
                user = currUser;
                authResult = AuthResult.isLogin;
                setState(() {});
              }
              return null;
            });
          },
        );
      case AuthResult.isLogin:
        return HomeScreen(
          logOut: () async {
            user = await widget.authAction.logOut();
            authResult = AuthResult.isNotLogin;
            setState(() {});
          },
          user: user,
        );
    }
    return null;
  }
}
