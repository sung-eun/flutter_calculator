import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  State createState() => new CalculatorState();
}

class CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Calculator"),
        ),
        body: new GridView.count(
          crossAxisCount: 4,
          children: new List<Widget>.generate(20, (index) {
            return new GridTile(
              child: new Card(
                  child: new Center(
                    child: new Text('$index'),
                  )),
            );
          }),
        ));
  }
}
