import 'package:calculate_expression/models/math_operations.dart';
import 'package:calculate_expression/helpers/math_parser.dart';
import 'package:calculate_expression/models/parse_result.dart';
import 'package:test/test.dart';
import 'package:tuple/tuple.dart';

class TestParser with MathParser {}

void main() {
  final parser = TestParser();

  group('Test of extract expression', () {
    final expr1 = '(x*3-5)/5';
    test(expr1, () {
      expect(
          parser.extractBracketExpression(expr1), Tuple2('(x*3-5)', 'x*3-5'));
    });

    final expr2 = '((x*3-5)/5)';
    test(expr2, () {
      expect(
          parser.extractBracketExpression(expr2), Tuple2('((x*3-5)/5)', '(x*3-5)/5'));
    });

    final expr3 = '10-40*(x*3-5)/5';
    test(expr3, () {
      expect(
          parser.extractBracketExpression(expr3), Tuple2('(x*3-5)', 'x*3-5'));
    });
  });

  group(' Test of parseAndCalulate Method', () {
    final String exprsn1 = '1+4*10';
    test(exprsn1, () {
      expect(
        parser.parseAndCalculate(MathOperation.multiplication, exprsn1),
        ParseResult(
          substring: '4*10',
          calcResult: 40,
          changedExpression: '1+40.0',
        ),
      );
    });

    final String exprsn2 = '1+4/10+13';
    test(exprsn2, () {
      expect(
        parser.parseAndCalculate(MathOperation.division, exprsn2),
        ParseResult(
          substring: '4/10',
          calcResult: 0.4,
          changedExpression: '1+0.4+13',
        ),
      );
    });

    final String exprsn3 = '1+400/10+13';
    test(exprsn3, () {
      expect(
        parser.parseAndCalculate(MathOperation.division, exprsn3),
        ParseResult(
          substring: '400/10',
          calcResult: 40,
          changedExpression: '1+40.0+13',
        ),
      );
    });

    final String exprsn4 = '1+40';
    test(exprsn4, () {
      expect(
        parser.parseAndCalculate(MathOperation.addition, exprsn4),
        ParseResult(
          substring: '1+40',
          calcResult: 41,
          changedExpression: '41.0',
        ),
      );
    });

    final String exprsn5 = '1-40';
    test(exprsn5, () {
      expect(
        parser.parseAndCalculate(MathOperation.subtraction, exprsn5),
        ParseResult(
          substring: '1-40',
          calcResult: -39,
          changedExpression: '-39.0',
        ),
      );
    });
  });
}
