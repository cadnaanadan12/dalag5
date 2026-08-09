import 'package:flutter/foundation.dart' hide Category;

import '../models/price_item.dart';
import '../services/market_data_service.dart';

class MarketDataProvider extends ChangeNotifier {
  List<PriceItem> _items = [];

  List<PriceItem> get items => _items;

  MarketDataProvider() {
    // Load initial data for default city (Hargeisa)
    _items = MarketDataService.getDataForCity('Hargeisa');
  }

  void updateCity(String city) {
    _items = MarketDataService.getDataForCity(city);
    notifyListeners();
  }

  void addPriceItem(PriceItem item) {
    // In real app, you'd send to backend; here we just add to local list
    _items.add(item);
    notifyListeners();
  }

  // Filter by category
  List<PriceItem> getByCategory(Category? category) {
    if (category == null) return _items;
    return _items.where((item) => item.category == category).toList();
  }
}
