sealed class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => message;
}

final class StorageException extends AppException {
  const StorageException(super.message);
}

final class LevelLoadException extends AppException {
  const LevelLoadException(super.message);
}

final class SimulationException extends AppException {
  const SimulationException(super.message);
}
