import 'package:equatable/equatable.dart';

class ParseResult extends Equatable {
  final String substring;
  final double calcResult;
  final String changedExpression;

  ParseResult({
    required this.substring,
    required this.calcResult,
    required this.changedExpression,
  });

  @override
  List<Object?> get props => [substring, calcResult, changedExpression];
}
