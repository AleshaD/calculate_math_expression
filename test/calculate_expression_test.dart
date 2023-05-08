import 'package:calculate_expression/calculate_expression.dart';
import 'package:test/test.dart';

void main() {
  final String exprsn1 = '10*5+4/2-1';
  final result1 = 51;
  test('$exprsn1 = $result1', () {
    expect(
      CalculateExpression(expression: exprsn1).result,
      result1,
    );
  });

  final String exprsn2 = '(x*3-5)/5';
  final result2 = 5;
  test('$exprsn2 = $result2', () {
    expect(
      CalculateExpression(
        expression: exprsn2,
        arguments: {'x': 10.0},
      ).result,
      result2,
    );
  });

  final String exprsn3 = '3*x+15/(3+2)';
  final args3 = {'x': 10.0};
  final result3 = 33;
  test('$exprsn3 = $result3  :  args: $args3', () {
    expect(
      CalculateExpression(
        expression: exprsn3,
        arguments: {'x': 10.0},
      ).result,
      result3,
    );
  });

  final String exprsn4 = '(2+3)*(5/(3.5-1))';
  final result4 = 10;
  test('$exprsn4 = $result4', () {
    expect(
      CalculateExpression(
        expression: exprsn4,
      ).result,
      result4,
    );
  });

  final String exprsn5 = '(83*(2+3)*(50/(x-5)*3+100))*y';
  final args5 = {'x': 10.0, 'y': -1.0};
  final result5 = -53950;
  test('$exprsn5 = $result5  :  args: $args5', () {
    expect(
      CalculateExpression(
        expression: exprsn5,
        arguments: args5,
      ).result,
      result5,
    );
  });

  final String exprsn6 = '3+(5*2+(4-2*(6-3)))';
  final result6 = 11;
  test('$exprsn6 = $result6', () {
    expect(
      CalculateExpression(
        expression: exprsn6,
        arguments: args5,
      ).result,
      result6,
    );
  });

  final String exprsn7 = '-1*8*((((4+21)/5+10-2)+6)*3-2)';
  final result7 = -440;
  test('$exprsn7 = $result7', () {
    expect(
      CalculateExpression(
        expression: exprsn7,
        arguments: args5,
      ).result,
      result7,
    );
  });
}
