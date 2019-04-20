import 'dart:collection';

import 'data/database.dart';
import 'data/model.dart';

var operators = <String>['×', '−', '+', '÷', '%', '²', '³'];

class Calculator {
  Calculator();

  Queue<String> operatorQueue = new ListQueue<String>();
  Queue<num> digitQueue = new ListQueue<num>();

  num parseExpression(String expression) {
    expression.split(' ').forEach((String c) {
      if (isOperator(c)) {
        if (operatorQueue.isEmpty) {
          operatorQueue.addLast(c);
        } else {
          while (operatorQueue.isNotEmpty &&
              digitQueue.isNotEmpty &&
              getPriority(c) <= getPriority(operatorQueue.last)) {
            calculate();
          }
          operatorQueue.addLast(c);
        }
      } else if (isNumeric(c)) {
        digitQueue.addLast(num.parse(c));
      }
    });

    while (operatorQueue.isNotEmpty) {
      calculate();
    }

    num result = digitQueue.removeLast();
    DatabaseHelper.instance.insert(HistoryData(expression, result.toString()));
    return result;
  }

  void calculate() {
    num op1 = digitQueue.removeLast();
    String op = operatorQueue.removeLast();

    num res;

    if (op == '²' || op == '³') {
      res = doOperateSquare(op1, op);
    } else {
      num op2 = digitQueue.removeLast();
      res = doOperate(op2, op1, op);
    }
    digitQueue.addLast(res);
  }

  num doOperate(num op1, num op2, String op) {
    switch (op) {
      case '+':
        return op1 + op2;
      case '−':
        return op1 - op2;
      case '×':
        return op1 * op2;
      case '÷':
        return op1 / op2;
      case '%':
        return op1 % op2;
      default:
        return 0;
    }
  }

  num doOperateSquare(num op1, String op) {
    switch (op) {
      case '²':
        return op1 * op1;
      case '³':
        return op1 * op1 * op1;
      default:
        return 1;
    }
  }

  int getPriority(String op) {
    switch (op) {
      case '+':
      case '−':
        return 0;
      case '×':
      case '÷':
      case '%':
        return 1;
      case '²':
      case '³':
        return 2;
      default:
        return -1;
    }
  }

  bool isOperator(String op) {
    return operators.contains(op);
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
}
