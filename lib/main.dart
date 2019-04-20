import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'calculator.dart';
import 'history.dart';
import 'keypad.dart';

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
                style: TextStyle(fontSize: 30.0, color: Colors.black54),
                textAlign: TextAlign.right)));

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
                    textAlign: TextAlign.right))));

    return Expanded(
      flex: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[expressionWidget, outputWidget],
      ),
    );
  }

  void onKeyPadClick(Button key) {
    final buttonValue = key.buttonValue;
    final displayValue = key.displayValue;
    final keyType = key.keyType;

    var _expression = expression;
    var _output = "";

    final length = _expression.length;
    bool isOperatorPossible =
        _expression.isNotEmpty && isNumeric(_expression[length - 1]);

    if (buttonValue == '⌫' && _expression.isNotEmpty) {
      num deleteLength;
      if (_expression[length - 1] == " ") {
        deleteLength = 3;
      } else {
        deleteLength = 1;
      }
      _expression = _expression.substring(0, length - deleteLength);
    } else if (output.isNotEmpty || buttonValue == 'C') {
      _expression = "";
    } else if (buttonValue == '=') {
      final calculator = new Calculator();
      _output = calculator.parseExpression(expression).toString();
    } else if (keyType == KeyType.POINT &&
        isDecimalPointPossible(_expression)) {
      _expression += displayValue;
    } else if (keyType == KeyType.DIGIT ||
        (keyType == KeyType.RANDOM &&
            (_expression.isEmpty || _expression[length - 1] == ' '))) {
      _expression += displayValue;
    } else if (keyType == KeyType.OPERATOR && isOperatorPossible) {
      _expression += " " + displayValue + " ";
    }

    setState(() {
      expression = _expression;
      output = _output;
    });
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    try {
      return double.parse(s) != null;
    } catch (exception) {
      return false;
    }
  }

  bool isDecimalPointPossible(String s) {
    if (s.isEmpty || s[s.length - 1] == " ") {
      return true;
    }

    List<String> values = s.split(" ");
    String lastNumber = values[values.length - 1];
    bool isContainsDot = !lastNumber.contains(r".");
    return isContainsDot;
  }

  num getRandomNumber() {
    return new Random().nextDouble();
  }

  void copyOutput(String output) {
    Clipboard.setData(ClipboardData(text: output));

    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text("복사되었습니다."),
    ));
  }
}
