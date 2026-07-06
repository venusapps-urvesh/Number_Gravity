import 'firebase_service.dart';

class FirebaseServiceStub implements FirebaseService {
  @override
  Future<void> initialize() async {}

  @override
  Future<void> logEvent(String name, Map<String, Object?> params) async {}

  @override
  Future<String?> getRemoteConfigString(String key) async => null;

  @override
  Future<void> setCrashlyticsKey(String key, String value) async {}
}
