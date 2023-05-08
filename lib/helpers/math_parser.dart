import 'package:calculate_expression/models/brackets.dart';
import 'package:calculate_expression/models/math_operations.dart';
import 'package:calculate_expression/models/parse_result.dart';
import 'package:tuple/tuple.dart';

mixin MathParser {
  ParseResult? parseAndCalculate(MathOperation operation, String expression) {
    if (expression.contains(operation.symbol)) {
      final symbol = operation.symbol;
      final firstNum = _firstNumber(symbol, expression);
      final secondNum = _secondNumber(symbol, expression);
      final substring = expression.substring(firstNum.item1, secondNum.item1);
      final calcResult = _calc(operation, firstNum.item2, secondNum.item2);

      return ParseResult(
        substring: substring,
        calcResult: calcResult,
        changedExpression: expression.replaceFirst(
          substring,
          calcResult.toString(),
        ),
      );
    }
    return null;
  }

  Tuple2<int, double> _firstNumber(String symbol, String expression) {
    final symbolIndex = expression.indexOf(symbol);
    int i = symbolIndex - 1;
    Tuple2<int, double>? result;
    while (i >= 0) {
      final substr = expression.substring(i, symbolIndex);

      try {
        if (!substr.startsWith('+')) {
          final n = double.parse(substr);
          result = Tuple2(i, n);
        }
      } catch (e) {
        break;
      }

      i--;
    }

    if (result == null) {
      throw (Exception(
          'Can not parse first number with symbol $symbol in $expression'));
    }

    return result;
  }

  Tuple2<int, double> _secondNumber(String symbol, String expression) {
    final symbolIndex = expression.indexOf(symbol);
    int i = symbolIndex + 2;
    Tuple2<int, double>? result;
    while (i <= expression.length) {
      final substr = expression.substring(symbolIndex + 1, i);

      try {
        if (substr != '-') {
          final n = double.parse(substr);
          result = Tuple2(i, n);
        }
      } catch (e) {
        break;
      }

      i++;
    }

    if (result == null) {
      throw (Exception(
          'Can not parse second number with symbol $symbol in $expression'));
    }

    return result;
  }

  /// Tuple<substring, expression>
  Tuple2<String, String> extractBracketExpression(String expr) {
    final openInd = expr.indexOf(Brackets.open.symbol);
    int closeInd = openInd + 1;
    int skip = 0;
    while (closeInd < expr.length) {
      final char = expr[closeInd];

      if (char == Brackets.open.symbol) {
        skip++;
      }

      if (char == Brackets.close.symbol) {
        if (skip == 0) {
          return Tuple2(
            expr.substring(openInd, closeInd + 1),
            expr.substring(openInd + 1, closeInd),
          );
        } else {
          skip--;
        }
      }

      closeInd++;
    }

    throw (Exception('Can not extractBracketExpression in $expr'));
  }

  double _calc(MathOperation operation, double first, double second) {
    switch (operation) {
      case MathOperation.division:
        return first / second;
      case MathOperation.multiplication:
        return first * second;
      case MathOperation.addition:
        return first + second;
      case MathOperation.subtraction:
        return first - second;
    }
  }
}
