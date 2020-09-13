import 'package:flutter/material.dart';
import '../settings/settings.dart';

class CustomNavigationBar extends StatefulWidget {
  final Function(int) currentSelectedItem;
  CustomNavigationBar({@required this.currentSelectedItem});
  @override
  _CustomNavigationBarState createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int selectedItem = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedItem,
      onTap: (currItem) {
        setState(() {
          selectedItem = currItem;
          widget.currentSelectedItem(currItem);
        });
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: selectedItem == 0
                  ? MainColors.secondarycolor
                  : MainColors.blackcolor,
            ),
            title: Text(
              'Home',
              style: TextStyle(color: MainColors.blackcolor),
            )),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: selectedItem == 1
                  ? MainColors.secondarycolor
                  : MainColors.blackcolor,
            ),
            title: Text(
              'Profile',
              style: TextStyle(color: MainColors.blackcolor),
            ))
      ],
    );
  }
}
