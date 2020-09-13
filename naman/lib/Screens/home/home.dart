import 'package:flutter/material.dart';
import 'item_list.dart';
import '../../settings/settings.dart';
import '../../CustomBottomBar/custom_nevigation_bar.dart';
import 'profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';

class HomeScreen extends StatefulWidget {
  final Function logOut;
  final User user;
  HomeScreen({@required this.logOut, @required this.user});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentItem = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Feed Me",
          style: TextStyle(
              color: Colors.cyanAccent[700],
              fontWeight: FontWeight.bold,
              fontSize: 22),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: MainColors.whitecolor,
      ),
      body: currentItem == 1
          ? ProfileScreen(
              logout: () {
                widget.logOut();
              },
            )
          : ItemList(user: widget.user),
      bottomNavigationBar: CustomNavigationBar(
        currentSelectedItem: (value) {
          setState(() {
            currentItem = value;
          });
        },
      ),
    );
  }
}
