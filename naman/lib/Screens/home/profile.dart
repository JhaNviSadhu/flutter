import 'package:flutter/material.dart';
import '../../settings/settings.dart';
//import '../../Screens/Auth/login.dart';

class ProfileScreen extends StatelessWidget {
  final Function logout;
  ProfileScreen({@required this.logout});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            color: MainColors.blackcolor,
            onPressed: () {
              logout();
            },
            child: Text(
              'Log out',
              style: TextStyle(color: MainColors.whitecolor),
            ),
          ),
        ],
      ),
    );
  }
}
