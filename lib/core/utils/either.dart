sealed class Either<LeftType, RightType> {
  const Either();

  ResultType fold<ResultType>(
    ResultType Function(LeftType value) onLeft,
    ResultType Function(RightType value) onRight,
  );
}

final class Left<LeftType, RightType> extends Either<LeftType, RightType> {
  final LeftType value;

  const Left(this.value);

  @override
  ResultType fold<ResultType>(
    ResultType Function(LeftType value) onLeft,
    ResultType Function(RightType value) onRight,
  ) => onLeft(value);
}

final class Right<LeftType, RightType> extends Either<LeftType, RightType> {
  final RightType value;

  const Right(this.value);

  @override
  ResultType fold<ResultType>(
    ResultType Function(LeftType value) onLeft,
    ResultType Function(RightType value) onRight,
  ) => onRight(value);
}
