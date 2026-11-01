abstract class Failure {
  final String messageKey;

  const Failure(this.messageKey);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          messageKey == other.messageKey;

  @override
  int get hashCode => messageKey.hashCode;

  @override
  String toString() => messageKey;
}

class ServerFailure extends Failure {
  const ServerFailure([super.messageKey = 'error_unknown']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.messageKey = 'error_unknown']);
}
