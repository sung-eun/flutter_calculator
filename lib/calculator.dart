import 'dart:collection';

var digits = <String>['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
var operators = <String>['×', '−', '+', '÷'];

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
      } else {
        digitQueue.addLast(num.parse(c));
      }
    });

    while (operatorQueue.isNotEmpty) {
      calculate();
    }

    return digitQueue.removeLast();
  }

  num calculate() {
    num op1 = digitQueue.removeLast();
    num op2 = digitQueue.removeLast();
    String op = operatorQueue.removeLast();

    num res = doOperate(op2, op1, op);
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
      default:
        return 0;
    }
  }

  int getPriority(String op) {
    switch (op) {
      case '+':
      case '−':
        return 0;
      case '×':
      case '÷':
        return 1;
      default:
        return -1;
    }
  }

  bool isOperator(String op) {
    return operators.contains(op);
  }

  bool isDigit(String op) {
    return digits.contains(op);
  }
}
