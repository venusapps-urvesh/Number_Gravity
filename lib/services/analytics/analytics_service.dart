import '../firebase/firebase_service.dart';

class AnalyticsService {
  AnalyticsService(this._firebaseService);

  final FirebaseService _firebaseService;

  Future<void> logAppOpen() {
    return _firebaseService.logEvent('app_open', const {});
  }

  Future<void> logScreenView(String screenName) {
    return _firebaseService.logEvent(
      'screen_view',
      {'screen_name': screenName},
    );
  }

  Future<void> logLevelStart(int levelId) {
    return _firebaseService.logEvent(
      'level_start',
      {'level_id': levelId},
    );
  }
}
