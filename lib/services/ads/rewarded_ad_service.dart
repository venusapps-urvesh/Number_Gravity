abstract class RewardedAdService {
  Future<bool> showRewardedAd();
  bool get canShowToday;
}

class RewardedAdServiceStub implements RewardedAdService {
  int _shownToday = 0;

  @override
  bool get canShowToday => _shownToday < 5;

  @override
  Future<bool> showRewardedAd() async {
    if (!canShowToday) {
      return false;
    }
    _shownToday++;
    return true;
  }
}
