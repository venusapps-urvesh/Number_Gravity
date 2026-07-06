abstract class PurchaseService {
  Future<void> loadProducts();
  Future<bool> purchaseCoinPack(String productId);
}

class PurchaseServiceStub implements PurchaseService {
  @override
  Future<void> loadProducts() async {}

  @override
  Future<bool> purchaseCoinPack(String productId) async => true;
}
