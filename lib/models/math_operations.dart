enum MathOperation {
  division('/'),
  multiplication('*'),
  addition('+'),
  subtraction('-');

  const MathOperation(this.symbol);

  final String symbol;
}
