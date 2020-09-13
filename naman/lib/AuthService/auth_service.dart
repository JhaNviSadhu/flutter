import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AuthAction {
  Future<User> currentUser();

  Future<User> logOut();

  Future<User> createUser(email, password);
  Future<User> singInUser(email, password);
}

class AuthService implements AuthAction {
  User user;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<User> currentUser() async {
    try {
      user = firebaseAuth.currentUser;
    } catch (e) {
      print(e);
    }
    return user;
  }

  Future<User> createUser(email, password) async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((currUser) {
        user = currUser.user;
      }).then((value) {
        FirebaseFirestore.instance
            .collection('Favorites')
            .doc(user.uid)
            .set({});
      });
    } catch (e) {
      print(e);
    }
    return user;
  }

  Future<User> singInUser(email, password) async {
    try {
      firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((currUser) {
        user = currUser.user;
      });
    } catch (e) {
      print(e);
    }
    return user;
  }

  Future<User> logOut() async {
    try {
      // ignore: await_only_futures
      await firebaseAuth.signOut();
      user = null;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
