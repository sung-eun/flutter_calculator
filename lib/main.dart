import 'package:flutter/material.dart';

import 'history.dart';

void main() => runApp(MyApp());

typedef KeyPadCallBack = void Function(String key);

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  var expression = "0";
  var output = "";

  @override
  Widget build(BuildContext context) {
    // set material design app
    return MaterialApp(
        title: 'solocoding2019', // application name
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text("Calculator"),
              actions: <Widget>[IconButton(
                icon: Icon(Icons.history),
                onPressed: () {
                  Navigator.push(context,
                      new MaterialPageRoute(
                          builder: (context) => new History()));
                },
              )
              ],
            ),
            body: Column(
              children: <Widget>[buildLabels(), KeyPad(onKeyPadClick)],
            )));
  }

  Expanded buildLabels() {
    var expressionWidget = Text(
      expression,
      style: TextStyle(fontSize: 35.0, color: Colors.black),
      textAlign: TextAlign.right,
    );

    var outputWidget = Text(
      output,
      style: TextStyle(fontSize: 35.0, color: Colors.black),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[expressionWidget, outputWidget],
            ),
          ),
        ));
  }

  void onKeyPadClick(String key) {
    setState(() {
      expression = key;
    });
  }
}

class KeyPad extends StatelessWidget {
  final KeyPadCallBack keyPadCallBack;

  KeyPad(this.keyPadCallBack);

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      flex: 4,
      child: new GridView.count(
        crossAxisCount: 4,
        children: <String>[
              'C', '%', 'x²', 'x³',
              '7', '8', '9', '×',
              '4', '5', '6', '−',
              '1', '2', '3', '+',
              '0', '.', 'x!', '='
            ].map((key) {
              return new GridTile(
                child: new KeyPadButton(key, keyPadCallBack),
              );
            }).toList(),
        ),
    );
  }
}

class KeyPadButton extends StatelessWidget {
  final keyValue;
  final KeyPadCallBack keyPadCallBack;

  KeyPadButton(this.keyValue, this.keyPadCallBack);

  @override
  Widget build(BuildContext context) {
    return new OutlineButton(
      child: new Text(
        keyValue,
        style: new TextStyle(
          fontSize: 20.0,
          color: Colors.black,
        ),
      ),
      borderSide: BorderSide(width: 0.25, color: Colors.black12),
      onPressed: () {
        keyPadCallBack(keyValue);
      },
    );
  }
}
