import 'package:flutter/foundation.dart';

class NotificationProvider extends ChangeNotifier {
  bool _priceAlerts = true;
  bool _marketUpdates = true;

  bool get priceAlerts => _priceAlerts;
  bool get marketUpdates => _marketUpdates;

  void togglePriceAlerts() {
    _priceAlerts = !_priceAlerts;
    notifyListeners();
  }

  void toggleMarketUpdates() {
    _marketUpdates = !_marketUpdates;
    notifyListeners();
  }
}
