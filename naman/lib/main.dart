//import 'dart:io';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Screens/home/item_description.dart';
import 'Screens/home/image_silder.dart';
import 'Screens/widget_tree.dart';
// ignore: duplicate_import
import 'package:flutter/material.dart';
import 'AuthService/auth_service.dart';
import 'package:firebase_core/firebase_core.dart';
import './settings/settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  get widget => null;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'naman',
      theme: ThemeData(
        //  appBarTheme: AppBarTheme(color: MainColors.primarycolor),
        scaffoldBackgroundColor: MainColors.primarycolor,
        primaryColor: MainColors.primarycolor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(
        create: (BuildContext context) {
          return ImageSilder();
        },
        child: SystemUI(),
      ),
      routes: {
        ItemDescription.routeName: (BuildContext context) => ItemDescription(),
      },
    );
  }
}

class SystemUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return AnnotatedRegion<SystemUiOverlayStyle>(
        child: WidgetTree(
          authAction: AuthService(),
        ),
        value: SystemUiOverlayStyle(
            systemNavigationBarColor: MainColors.primarycolor,
            systemNavigationBarIconBrightness: Brightness.dark));
  }
}
