import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:naman/Screens/home/item_list_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'item_list_widget.dart';

class ItemList extends StatefulWidget {
  final User user;
  ItemList({@required this.user});
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  futureBuilder() async {
    currentFavorites = [];
    await FirebaseFirestore.instance
        .collection('Favorites')
        .doc(widget.user.uid)
        .get()
        .then((favorites) {
      favorites.data().forEach((key, value) {
        currentFavorites.add(key);
      });
      print(favorites.data);
    });
  }

  List<String> currentFavorites = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureBuilder(),
        builder: (BuildContext futurecontext, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? CircularProgressIndicator()
              : ItemListWidget(
                  user: widget.user,
                  currentFav: currentFavorites,
                );
        });
  }
}
