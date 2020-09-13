import 'package:flutter/material.dart';

class ImageSilderDots extends StatefulWidget {
  final currentPage;
  ImageSilderDots({@required this.currentPage});
  @override
  _ImageSilderDotsState createState() => _ImageSilderDotsState();
}

class _ImageSilderDotsState extends State<ImageSilderDots> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(4, (index) {
          return Container(
            margin: EdgeInsets.all(2),
            height: 10,
            width: 10,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    widget.currentPage == index ? Colors.white : Colors.grey),
          );
        }),
      ),
    );
  }
}
