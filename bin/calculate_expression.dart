import 'package:calculate_expression/calculate_expression.dart';

void main(List<String> arguments) {
  if (arguments.isNotEmpty) {
    final expr = arguments[0];
    Map<String, double>? args;
    if (arguments.length > 1) {
      args = arguments[1] as Map<String, double>?;
    }
    print('Calculate $expr');
    final result = CalculateExpression(expression: expr, arguments: args).result;
    print('Result = $result');
  } else {
    print('Arguments is empty');
  }
}
