import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  State createState() => new CalculatorState();
}

class CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    final historyButton = IconButton(
      icon: Icon(Icons.history),
      onPressed: () {},
    );

    return Scaffold(
        appBar: AppBar(
          title: Text("Calculator"),
          actions: <Widget>[historyButton],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "0",
                    style: TextStyle(fontSize: 50.0, color: Colors.black),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              Expanded(
                  child: GridView.count(
                      crossAxisCount: 4,
                      children: List<Widget>.generate(20, (index) {
                        return GridTile(
                          child: Card(
                              child: Center(
                            child: Text('$index'),
                          )),
                        );
                      })))
            ],
          ),
        ));
  }
}
