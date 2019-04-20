import 'calculator.dart';
import 'keypad_ui.dart';

class KeyPadCallback {
  static Pair<String> onKeyPadClick(
      String expression, String output, Button key) {
    final buttonValue = key.buttonValue;
    final displayValue = key.displayValue;
    final keyType = key.keyType;
    final length = expression.length;
    final hasOutput = output.isNotEmpty;

    output = "";

    if (buttonValue == '⌫' && expression.isNotEmpty) {
      num deleteLength;
      if (expression[length - 1] == " ") {
        deleteLength = 3;
      } else {
        deleteLength = 1;
      }
      expression = expression.substring(0, length - deleteLength);
    } else if (buttonValue == 'C' ||
        (keyType != KeyType.OPERATOR && hasOutput)) {
      expression = displayValue;
    } else if (key.buttonValue == '=') {
      final calculator = new Calculator();
      output = calculator.parseExpression(expression.trim()).toString();
    } else if (keyType == KeyType.OPERATOR && _isOperatorPossible(expression)) {
      expression += " " + displayValue + " ";
    } else if ((keyType == KeyType.POINT &&
            _isDecimalPointPossible(expression)) ||
        (keyType == KeyType.DIGIT ||
            (keyType == KeyType.RANDOM &&
                (expression.isEmpty || expression[length - 1] == ' ')))) {
      expression += displayValue;
    }

    return Pair(expression, output);
  }

  static _isOperatorPossible(String s) {
    if (s.isEmpty) {
      return false;
    }

    List<String> values = s.split(" ");
    String lastValue = values[values.length - 1];
    return _isNumeric(lastValue) || s.endsWith('² ') || s.endsWith('³ ');
  }

  static bool _isNumeric(String s) {
    if (s == null) {
      return false;
    }

    try {
      return double.parse(s) != null;
    } catch (exception) {
      return false;
    }
  }

  static bool _isDecimalPointPossible(String s) {
    if (s.isEmpty || s[s.length - 1] == " ") {
      return true;
    }

    List<String> values = s.split(" ");
    String lastValue = values[values.length - 1];
    bool isContainsDot = !lastValue.contains(r".");
    return isContainsDot;
  }
}

class Pair<T> {
  final T first;
  final T second;

  Pair(this.first, this.second);
}
