import 'package:flutter/material.dart';

class MainColors {
  static const primarycolor = Color.fromRGBO(242, 242, 242, 1.0);
  static final secondarycolor = Colors.teal[100];
  static const whitecolor = Colors.white;
  static const blackcolor = Colors.black;
  static final bluecolor = Colors.blue[800];
  static final greencolor = Colors.green[600];
}

class CustomeButton extends StatelessWidget {
  final Color color;
  final String text;
  final Function function;
  final Color textcolor;
  CustomeButton(
      {@required this.text,
      @required this.color,
      @required this.function,
      @required this.textcolor});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        onPressed: function,
        child: Text(
          text,
          style: TextStyle(color: textcolor),
        ),
        color: color);
  }
}
