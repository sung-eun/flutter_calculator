import 'package:flutter/material.dart';

import 'calculator.dart';

void main() => runApp(MyApp());

// This widget is the root of your application.
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // set material design app
    return MaterialApp(
        title: 'solocoding2019', // application name
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: Calculator());
  }
}
