import '../../storage/adapters/player_progress.dart';

abstract class CloudSaveService {
  Future<void> upload(PlayerProgress progress);
  Future<PlayerProgress?> download();
}

class CloudSaveServiceStub implements CloudSaveService {
  PlayerProgress? _cached;

  @override
  Future<PlayerProgress?> download() async => _cached;

  @override
  Future<void> upload(PlayerProgress progress) async {
    _cached = progress;
  }
}
