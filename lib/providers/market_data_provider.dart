// lib/providers/market_data_provider.dart
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' hide Category;

import '../models/price_item.dart';

class MarketDataProvider extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  List<PriceItem> _items = [];
  String _city = 'Hargeisa';

  StreamSubscription<QuerySnapshot>? _sub;

  List<PriceItem> get items => _items;
  String get currentCityName => _city;

  MarketDataProvider() {
    updateCity('Hargeisa');
  }

  void updateCity(String city) {
    _city = city;
    _sub?.cancel();
    _sub = _db
        .collection('market_prices')
        .where('city', isEqualTo: city)
        .snapshots()
        .listen((snapshot) {
      _items = snapshot.docs.map((doc) {
        final data = doc.data();
        return PriceItem(
          id: doc.id,
          nameEn: data['nameEn'] ?? '',
          nameSo: data['nameSo'] ?? '',
          unitEn: data['unitEn'] ?? '',
          unitSo: data['unitSo'] ?? '',
          price: (data['price'] as num).toDouble(),
          changePercent: (data['changePercent'] as num).toDouble(),
          imageAsset: data['imageAsset'] ?? 'assets/images/tomato.jpg',
          category: Category.values.firstWhere(
              (c) => c.name == data['category'],
              orElse: () => Category.vegetables),
          city: data['city'] ?? city,
        );
      }).toList();
      notifyListeners();
    });
  }

  Future<void> addPriceItem(PriceItem item) async {
    await _db.collection('market_prices').doc('${item.id}_${item.city}').set({
      'nameEn': item.nameEn,
      'nameSo': item.nameSo,
      'unitEn': item.unitEn,
      'unitSo': item.unitSo,
      'price': item.price,
      'changePercent': item.changePercent,
      'imageAsset': item.imageAsset,
      'category': item.category.name,
      'city': item.city,
      'updatedAt': FieldValue.serverTimestamp(),
    });
    // Ma baahna notifyListeners() halkan — snapshots() ayaa si toos
    // ah wax uga bedeli doona dhammaan qalabka isku mar isticmaalaya app-ka.
  }

  /// Tirtirta hal alaab oo Firestore ah. [id] waa document ID-ga
  /// (isla PriceItem.id, tusaale: "tomato_Hargeisa").
  Future<void> deletePriceItem(String id) async {
    await _db.collection('market_prices').doc(id).delete();
    // snapshots() stream-ku otomaatig ayuu ka saari doonaa listka —
    // ma baahna in gacanta lagu tirtiro _items ama la yiraahdo
    // notifyListeners() halkan.
  }

  List<PriceItem> getByCategory(Category? category) {
    if (category == null) return _items;
    return _items.where((item) => item.category == category).toList();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
