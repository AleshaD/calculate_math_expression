import 'package:calculate_expression/helpers/math_parser.dart';
import 'package:calculate_expression/models/brackets.dart';
import 'package:calculate_expression/models/math_operations.dart';

class CalculateExpression with MathParser {
  CalculateExpression({
    required String expression,
    this.arguments,
  }) : expression = _setupArguments(expression, arguments);

  final String expression;
  final Map<String, double>? arguments;

  double? _result;
  double get result {
    _result ??= _calculate(expression);
    return _result!;
  }

  /// Вычисление математического выражения с учётом скобок
  double _calculate(String expr) {
    if (expr.contains(Brackets.open.symbol)) {
      final tuple = extractBracketExpression(expr);
      final substring = tuple.item1;
      final extractedExpr = tuple.item2;
      final changedExpr = expr.replaceAll(
        substring,
        _calculate(extractedExpr).toString(),
      );

      return _calculate(changedExpr);
    }

    return _calcMathOperations(expr);
  }

  /// Вычисление математических операций в выражении с учётом приоритета
  double _calcMathOperations(String expr) {
    String? result;
    if (expr.contains(MathOperation.division.symbol)) {
      result =
          parseAndCalculate(MathOperation.division, expr)?.changedExpression;
    } else if (expr.contains(MathOperation.multiplication.symbol)) {
      result = parseAndCalculate(MathOperation.multiplication, expr)
          ?.changedExpression;
    } else if (expr.contains(MathOperation.addition.symbol)) {
      result =
          parseAndCalculate(MathOperation.addition, expr)?.changedExpression;
    } else if (expr.contains(MathOperation.subtraction.symbol, 1)) {
      result = parseAndCalculate(
              MathOperation.addition, expr.replaceFirst('-', '+-', 1))
          ?.changedExpression;
    }

    if (result != null) {
      try {
        return double.parse(result);
      } catch (e) {
        return _calcMathOperations(result);
      }
    } else {
      throw (Exception('Can not _calcMathOperations in $expr, result is null'));
    }
  }

  static String _setupArguments(String initExpr, Map<String, double>? args) {
    if (args == null) return initExpr;
    for (var key in args.keys) {
      if (initExpr.contains(key)) {
        final val = args[key];
        initExpr = initExpr.replaceAll(key, val!.toString());
      }
    }

    return initExpr;
  }
}
