import 'package:flutter/material.dart';

import 'image_silder_dots.dart';

class ImageSilder extends ChangeNotifier {
  int currentPage;
  Widget getDotsWidget(currPage) {
    if (currentPage == null) {
      currentPage = 0;
    } else
      (currentPage = currPage);
    return ImageSilderDots(
      currentPage: currentPage,
    );
  }

  actualPage(pageNumber) {
    currentPage = pageNumber;
    notifyListeners();
  }
}
