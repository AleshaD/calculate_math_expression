import 'package:calculate_expression/calculate_expression.dart';
import 'package:test/test.dart';

void main() {
  final String exprsn1 = '1+4';
  test(exprsn1, () {
    expect(CalculateExpression(expression: exprsn1).result, 5);
  });

  final String exprsn2 = '2+1+4';
  test(exprsn2, () {
    expect(CalculateExpression(expression: exprsn2).result, 7);
  });

  final String exprsn3 = '2+1+4+10';
  test(exprsn3, () {
    expect(CalculateExpression(expression: exprsn3).result, 17);
  });

  final String exprsn4 = '20/5+4+10*3';
  test(exprsn4, () {
    expect(CalculateExpression(expression: exprsn4).result, 38);
  });

  final String exprsn5 = '2+1+4*10+10*4';
  test(exprsn5, () {
    expect(CalculateExpression(expression: exprsn5).result, 83);
  });

  final String exprsn6 = '2+1+4*-10+10*4';
  test(exprsn6, () {
    expect(CalculateExpression(expression: exprsn6).result, 3);
  });

  final String exprsn7 = '20*3-2+1+4*-10+10*4';
  test(exprsn7, () {
    expect(CalculateExpression(expression: exprsn7).result, 59);
  });

  final String exprsn8 = '20*3-2+1+4*-10+10*4-20*3-2+1+4*-10+10*4';
  test(exprsn8, () {
    expect(CalculateExpression(expression: exprsn8).result, -2);
  });
  
  final String exprsn9 = '-1-1';
  test(exprsn9, () {
    expect(CalculateExpression(expression: exprsn9).result, -2);
  });
}