import 'dart:math';

import 'package:flutter/material.dart';

typedef KeyPadCallBack = void Function(Button key);

enum KeyType { DIGIT, OPERATOR, EMPTY, PRIORITY, RANDOM, POINT }

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
        children: <Button>[
          Button('C', '', KeyType.OPERATOR),
          Button('(', '(', KeyType.PRIORITY),
          Button(')', ')', KeyType.PRIORITY),
          Button('%', '%', KeyType.OPERATOR),
          Button('⌫', '', KeyType.OPERATOR),
          Button('7', '7', KeyType.DIGIT),
          Button('8', '8', KeyType.DIGIT),
          Button('9', '9', KeyType.DIGIT),
          Button('+', '+', KeyType.OPERATOR),
          Button('x²', '²', KeyType.OPERATOR),
          Button('4', '4', KeyType.DIGIT),
          Button('5', '5', KeyType.DIGIT),
          Button('6', '6', KeyType.DIGIT),
          Button('−', '−', KeyType.OPERATOR),
          Button('x³', '³', KeyType.OPERATOR),
          Button('1', '1', KeyType.DIGIT),
          Button('2', '2', KeyType.DIGIT),
          Button('3', '3', KeyType.DIGIT),
          Button('×', '×', KeyType.OPERATOR),
          Button('🎲', new Random().nextDouble().toString(), KeyType.RANDOM),
          Button('0', '0', KeyType.DIGIT),
          Button('', '', KeyType.EMPTY),
          Button('.', '.', KeyType.POINT),
          Button('÷', '÷', KeyType.OPERATOR),
          Button('=', '', KeyType.OPERATOR)
        ].map((key) {
          return new GridTile(
            child: new KeyPadButton(key, keyPadCallBack),
          );
        }).toList(),
      ),
    );
  }
}

class Button {
  final String buttonValue;
  final String displayValue;
  final KeyType keyType;

  Button(this.buttonValue, this.displayValue, this.keyType);
}

class KeyPadButton extends StatelessWidget {
  final Button keyPad;
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
