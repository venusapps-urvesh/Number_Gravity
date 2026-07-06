abstract class FirebaseService {
  Future<void> initialize();

  Future<void> logEvent(String name, Map<String, Object?> params);

  Future<void> setCrashlyticsKey(String key, String value);

  Future<String?> getRemoteConfigString(String key);
}
