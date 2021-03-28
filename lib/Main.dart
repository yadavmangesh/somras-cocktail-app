import 'package:flutter/material.dart';
import 'package:somras/utils/constant.dart';
import 'package:somras/Login.dart';
import 'home/SomrasMain.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Somras',
      initialRoute: '/home',
      routes: {
        '/home':(context)=>Home()
      },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
         primaryColor: Constant.primaryColor,
         primaryColorDark: Constant.primaryDarkColor,
         primaryColorLight: Constant.accentColor,
         accentColor: Constant.accentColor,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}


