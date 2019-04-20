import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'history.dart';
import 'keypad_callback.dart';
import 'keypad_ui.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  BuildContext context;

  var expression = "";
  var output = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'solocoding2019', // application name
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text("Simple Calculator"),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.history),
                  onPressed: () {
                    Navigator.push(
                        this.context,
                        new MaterialPageRoute(
                            builder: (context) => new History()));
                  },
                )
              ],
            ),
            body: Builder(builder: (BuildContext context) {
              this.context = context;
              return Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[buildLabels(), KeyPad(onKeyPadClick)],
                ),
              );
            })));
  }

  Expanded buildLabels() {
    var expressionWidget = Container(
        alignment: Alignment.centerRight,
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(expression,
                style: TextStyle(
                    fontSize: 30.0, color: Colors.black54, letterSpacing: -0.8),
                textAlign: TextAlign.left)));

    var outputWidget = Container(
        alignment: Alignment.bottomRight,
        child: GestureDetector(
            onLongPress: () {
              copyOutput(output);
            },
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(output,
                    style: TextStyle(fontSize: 35.0, color: Colors.black),
                    textAlign: TextAlign.left))));

    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[expressionWidget, outputWidget],
      ),
    );
  }

  void onKeyPadClick(Button key) {
    final Pair<String> keyPadClickResult =
        KeyPadCallback.onKeyPadClick(expression, output, key);

    var _expression = keyPadClickResult.first;
    var _output = keyPadClickResult.second;

    setState(() {
      expression = _expression;
      output = _output;
    });
  }

  void copyOutput(String output) {
    Clipboard.setData(ClipboardData(text: output));

    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text("복사되었습니다."),
    ));
  }
}
