import 'package:flutter/material.dart';

import 'history.dart';

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
        home: Main());
  }
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final historyButton = IconButton(
      icon: Icon(Icons.history),
      onPressed: () {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new History()));
      },
    );

    return Scaffold(
        appBar: AppBar(
          title: Text("Calculator"),
          actions: <Widget>[historyButton],
        ),
        body: Column(
          children: <Widget>[Label(), KeyPad()],
        ));
  }
}

class Label extends StatefulWidget {
  @override
  State<Label> createState() {
    return LabelState();
  }
}

class LabelState extends State<Label> {
  var expression = "0";
  var output = "";

  @override
  Widget build(BuildContext context) {
    var expressionWidget = Text(
      expression,
      style: TextStyle(fontSize: 50.0, color: Colors.black),
      textAlign: TextAlign.right,
    );

    var outputWidget = Text(
      output,
      style: TextStyle(fontSize: 50.0, color: Colors.black),
      textAlign: TextAlign.right,
    );

    return Expanded(
        flex: 2,
        child: new Container(
          alignment: Alignment.centerRight,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[expressionWidget, outputWidget],
            ),
          ),
        ));
  }
}

class KeyPad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Expanded(
        flex: 4,
        child: new GridView.count(
            crossAxisCount: 4,
            padding: const EdgeInsets.all(1.5),
            children: <String>[
              'C', '%', 'x²', 'x³',
              '7', '8', '9', '×',
              '4', '5', '6', '−',
              '1', '2', '3', '+',
              '0', '.', 'x!', '='
            ].map((key) {
              return new GridTile(
                child: new KeyPadButton(key),
              );
            }).toList(),
          ),
        );
  }
}

class KeyPadButton extends StatelessWidget {
  KeyPadButton(this.keyValue);

  final keyValue;

  @override
  Widget build(BuildContext context) {
    return new OutlineButton(
      child: new Text(
        keyValue,
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22.0,
          color: Colors.black,
        ),
      ),
      borderSide: BorderSide(width: 0.5, color: Colors.black12),
      onPressed: () {
        onClickKeyPad(keyValue);
      },
    );
  }
}

void onClickKeyPad(String key) {
//TODO
}
