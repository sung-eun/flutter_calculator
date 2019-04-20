import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'calculator.dart';
import 'history.dart';

void main() => runApp(MyApp());

typedef KeyPadCallBack = void Function(Key key);

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

  void onKeyPadClick(Key key) {
    var _expression = expression;
    var _output = "";

    if (output.isNotEmpty) {
      _expression = "";
    }

    final buttonValue = key.buttonValue;
    final displayValue = key.displayValue;
    final keyType = key.keyType;

    if (buttonValue == 'C') {
      _expression = "";
      _output = "";
    } else if (buttonValue == '=') {
      final calculator = new Calculator();
      _output = calculator.parseExpression(expression).toString();
    } else if (keyType == KeyType.DIGIT) {
      _expression += displayValue;
    } else if (keyType == KeyType.OPERATOR) {
      //&& _expression.last == digit
      _expression += " " + displayValue + " ";
    }

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

class KeyPad extends StatelessWidget {
  final KeyPadCallBack keyPadCallBack;

  KeyPad(this.keyPadCallBack);

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      flex: 5,
      child: new GridView.count(
        shrinkWrap: true,
        primary: true,
        crossAxisCount: 5,
        children: <Key>[
          Key('C', '', KeyType.OPERATOR),
          Key('(', '(', KeyType.OPERATOR),
          Key(')', ')', KeyType.OPERATOR),
          Key('%', '%', KeyType.OPERATOR),
          Key('⌫', '', KeyType.OPERATOR),
          Key('7', '7', KeyType.DIGIT),
          Key('8', '8', KeyType.DIGIT),
          Key('9', '9', KeyType.DIGIT),
          Key('+', '+', KeyType.OPERATOR),
          Key('x²', '²', KeyType.OPERATOR),
          Key('4', '4', KeyType.DIGIT),
          Key('5', '5', KeyType.DIGIT),
          Key('6', '6', KeyType.DIGIT),
          Key('−', '−', KeyType.OPERATOR),
          Key('x³', '³', KeyType.OPERATOR),
          Key('1', '1', KeyType.DIGIT),
          Key('2', '2', KeyType.DIGIT),
          Key('3', '3', KeyType.DIGIT),
          Key('×', '×', KeyType.OPERATOR),
          Key('🎲', '', KeyType.OPERATOR),
          Key('0', '0', KeyType.DIGIT),
          Key('', '', KeyType.EMPTY),
          Key('.', '.', KeyType.DIGIT),
          Key('÷', '÷', KeyType.OPERATOR),
          Key('=', '', KeyType.OPERATOR)
        ].map((key) {
          return new GridTile(
            child: new KeyPadButton(key, keyPadCallBack),
          );
        }).toList(),
      ),
    );
  }
}

class Key {
  final String buttonValue;
  final String displayValue;
  final KeyType keyType;

  Key(this.buttonValue, this.displayValue, this.keyType);
}

class KeyPadButton extends StatelessWidget {
  final Key keyPad;
  final KeyPadCallBack keyPadCallBack;

  KeyPadButton(this.keyPad, this.keyPadCallBack);

  @override
  Widget build(BuildContext context) {
    return new OutlineButton(
      child: new Text(
        keyPad.buttonValue,
        style: new TextStyle(
          fontSize: 20.0,
          color: Colors.black,
        ),
      ),
      borderSide: BorderSide(width: 0.25, color: Colors.black12),
      highlightColor: Colors.white70,
      onPressed: () {
        keyPadCallBack(keyPad);
      },
    );
  }
}
