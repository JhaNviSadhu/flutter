import 'package:flutter/material.dart';
import '../../settings/settings.dart';

class LoginScreen extends StatefulWidget {
  final Function(String email, String password) createuser;
  final Function(String email, String password) singInUser;
  LoginScreen({
    @required this.createuser,
    @required this.singInUser,
  });
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

enum LoginOrRegister {
  login,
  regiser,
}

class _LoginScreenState extends State<LoginScreen> {
  LoginOrRegister loginOrRegister = LoginOrRegister.login;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String email;
  String password;
  bool hidepassword = true;
  List<Widget> buildTextField() {
    return [
      TextFormField(
        decoration: InputDecoration(
          hintText: 'Email',
          fillColor: MainColors.whitecolor,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
        ),
        onSaved: (newValue) => email = newValue,
        keyboardType: TextInputType.emailAddress,
      ),
      SizedBox(
        height: 10,
      ),
      TextFormField(
        decoration: InputDecoration(
            hintText: 'Password',
            fillColor: MainColors.whitecolor,
            filled: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
            suffixIcon: IconButton(
                icon: Icon(hidepassword == true ? Icons.lock : Icons.lock_open),
                onPressed: () {
                  setState(() {
                    hidepassword = !hidepassword;
                  });
                })),
        onSaved: (newValue) => password = newValue,
        obscureText: hidepassword,
      ),
      SizedBox(
        height: 5,
      ),
    ];
  }

  List<Widget> bulidWidgets() {
    if (loginOrRegister == LoginOrRegister.login) {
      return [
        CustomeButton(
            text: 'Sing In User',
            color: MainColors.blackcolor,
            function: () {
              globalKey.currentState.save();
              widget.singInUser(email, password);
            },
            textcolor: MainColors.whitecolor),
        RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          elevation: 0,
          color: Colors.transparent,
          onPressed: () {
            setState(() {
              loginOrRegister = LoginOrRegister.regiser;
            });
          },
          child: Text('Create User Instead'),
        )
      ];
    } else {
      return [
        CustomeButton(
            text: 'Create User',
            color: MainColors.blackcolor,
            function: () {
              globalKey.currentState.save();
              widget.createuser(email, password);
            },
            textcolor: MainColors.whitecolor),
        RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          elevation: 0,
          color: Colors.transparent,
          onPressed: () {
            setState(() {
              loginOrRegister = LoginOrRegister.login;
            });
          },
          child: Text('Sing In Instead'),
        )
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("fluttere"),
        elevation: 0,
        backgroundColor: MainColors.primarycolor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 80),
            child: Form(
              key: globalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: buildTextField() + bulidWidgets(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
