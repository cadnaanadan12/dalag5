// tool/seed_firestore.dart
//
// Script hal-mar ah oo shuba xogta khudaarta/suuqa ee Firestore
// collection-ka 'market_prices', isaga oo u qaybiya lixda magaalo.
//
// SIDA LOO ORDO (terminal-ka, root-ka project-ka):
//   dart run tool/seed_firestore.dart
//
// U BAAHAN: Firebase-ku waa in horey loogu daray project-ka
// (flutterfire configure) si 'firebase_options.dart' u jiro.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../lib/firebase_options.dart';

// ---- Xogta asaasiga ah (isla tan MarketDataService._baseItems) ----
final List<Map<String, dynamic>> _baseItems = [
  {
    'id': 'tomato',
    'nameEn': 'Tomatoes',
    'nameSo': 'Yaanyo',
    'unitEn': '1kg',
    'unitSo': '1kg',
    'price': 8.5,
    'changePercent': 2.4,
    'imageAsset': 'assets/images/tomato.jpg',
    'category': 'vegetables',
  },
  {
    'id': 'onion',
    'nameEn': 'Onions',
    'nameSo': 'Basal',
    'unitEn': '1kg',
    'unitSo': '1kg',
    'price': 6.2,
    'changePercent': -1.2,
    'imageAsset': 'assets/images/onion.jpg',
    'category': 'vegetables',
  },
  {
    'id': 'potato',
    'nameEn': 'Potatoes',
    'nameSo': 'Baradhada',
    'unitEn': '1kg',
    'unitSo': '1kg',
    'price': 5.4,
    'changePercent': 0.0,
    'imageAsset': 'assets/images/potato.jpg',
    'category': 'vegetables',
  },
  {
    'id': 'pepper',
    'nameEn': 'Peppers (Bell)',
    'nameSo': 'Basbaas',
    'unitEn': 'Bag (S)',
    'unitSo': 'Bag (S)',
    'price': 12.0,
    'changePercent': 5.8,
    'imageAsset': 'assets/images/pepper.jpg',
    'category': 'vegetables',
  },
  {
    'id': 'carrot',
    'nameEn': 'Carrots',
    'nameSo': 'Karooto',
    'unitEn': 'Bundle',
    'unitSo': 'Xidhmo',
    'price': 7.5,
    'changePercent': -3.1,
    'imageAsset': 'assets/images/carrot.jpg',
    'category': 'vegetables',
  },
  {
    'id': 'cabbage',
    'nameEn': 'Cabbage',
    'nameSo': 'Kabash',
    'unitEn': 'Piece',
    'unitSo': 'Xabbad',
    'price': 4.0,
    'changePercent': 1.2,
    'imageAsset': 'assets/images/cabbage.jpg',
    'category': 'vegetables',
  },
  {
    'id': 'cucumber',
    'nameEn': 'Cucumber',
    'nameSo': 'Qajaar',
    'unitEn': 'Piece',
    'unitSo': 'Xabbad',
    'price': 2.5,
    'changePercent': -0.8,
    'imageAsset': 'assets/images/cucumber.jpg',
    'category': 'vegetables',
  },
  {
    'id': 'chili',
    'nameEn': 'Chili Pepper',
    'nameSo': 'Basbaas Dhamme',
    'unitEn': 'Bag (S)',
    'unitSo': 'Bag (S)',
    'price': 15.0,
    'changePercent': 6.0,
    'imageAsset': 'assets/images/chili.jpg',
    'category': 'vegetables',
  },
  {
    'id': 'lettuce',
    'nameEn': 'Lettuce',
    'nameSo': 'Salad',
    'unitEn': 'Piece',
    'unitSo': 'Xabbad',
    'price': 3.0,
    'changePercent': 0.5,
    'imageAsset': 'assets/images/lettuce.jpg',
    'category': 'vegetables',
  },
  {
    'id': 'spinach',
    'nameEn': 'Spinach',
    'nameSo': 'Isbinaaj',
    'unitEn': 'Bundle',
    'unitSo': 'Xidhmo',
    'price': 3.5,
    'changePercent': -0.2,
    'imageAsset': 'assets/images/spinach.jpg',
    'category': 'vegetables',
  },
  {
    'id': 'cilantro',
    'nameEn': 'Coriander (Cilantro)',
    'nameSo': 'Kusbar',
    'unitEn': 'Bundle',
    'unitSo': 'Xidhmo',
    'price': 4.5,
    'changePercent': 2.0,
    'imageAsset': 'assets/images/cilantro.jpg',
    'category': 'vegetables',
  },
  {
    'id': 'pumpkin',
    'nameEn': 'Pumpkin',
    'nameSo': 'Booq',
    'unitEn': 'Piece',
    'unitSo': 'Xabbad',
    'price': 10.0,
    'changePercent': -1.5,
    'imageAsset': 'assets/images/pumpkin.jpg',
    'category': 'vegetables',
  },
  {
    'id': 'greenbeans',
    'nameEn': 'Green Beans',
    'nameSo': 'Dhiriyar',
    'unitEn': '1kg',
    'unitSo': '1kg',
    'price': 6.0,
    'changePercent': 1.8,
    'imageAsset': 'assets/images/greenbeans.jpg',
    'category': 'vegetables',
  },
  {
    'id': 'peas',
    'nameEn': 'Peas',
    'nameSo': 'Biskad',
    'unitEn': '1kg',
    'unitSo': '1kg',
    'price': 7.0,
    'changePercent': 0.0,
    'imageAsset': 'assets/images/peas.jpg',
    'category': 'vegetables',
  },
  {
    'id': 'beetroot',
    'nameEn': 'Beetroot',
    'nameSo': 'Beetroot',
    'unitEn': 'Bundle',
    'unitSo': 'Xidhmo',
    'price': 5.0,
    'changePercent': 2.5,
    'imageAsset': 'assets/images/beetroot.jpg',
    'category': 'vegetables',
  },
  {
    'id': 'okra',
    'nameEn': 'Okra',
    'nameSo': 'Baamiyo',
    'unitEn': '1kg',
    'unitSo': '1kg',
    'price': 8.0,
    'changePercent': 3.0,
    'imageAsset': 'assets/images/okra.jpg',
    'category': 'vegetables',
  },
  {
    'id': 'garlic',
    'nameEn': 'Garlic',
    'nameSo': 'Tuum',
    'unitEn': '1kg',
    'unitSo': '1kg',
    'price': 20.0,
    'changePercent': 4.0,
    'imageAsset': 'assets/images/garlic.jpg',
    'category': 'vegetables',
  },
  {
    'id': 'broccoli',
    'nameEn': 'Broccoli',
    'nameSo': 'Broccoli',
    'unitEn': 'Piece',
    'unitSo': 'Xabbad',
    'price': 9.0,
    'changePercent': 1.0,
    'imageAsset': 'assets/images/broccoli.jpg',
    'category': 'vegetables',
  },
  {
    'id': 'cauliflower',
    'nameEn': 'Cauliflower',
    'nameSo': 'Cauliflower',
    'unitEn': 'Piece',
    'unitSo': 'Xabbad',
    'price': 8.5,
    'changePercent': 0.5,
    'imageAsset': 'assets/images/cauliflower.jpg',
    'category': 'vegetables',
  },
  {
    'id': 'watermelon',
    'nameEn': 'Watermelon',
    'nameSo': 'Qarre',
    'unitEn': 'Piece',
    'unitSo': 'Xabbad',
    'price': 25.0,
    'changePercent': 0.0,
    'imageAsset': 'assets/images/watermelon.jpg',
    'category': 'fruits',
  },
  {
    'id': 'mango',
    'nameEn': 'Mango',
    'nameSo': 'Mango',
    'unitEn': '1kg',
    'unitSo': '1kg',
    'price': 12.0,
    'changePercent': 3.2,
    'imageAsset': 'assets/images/mango.jpg',
    'category': 'fruits',
  },
  {
    'id': 'sorghum',
    'nameEn': 'Sorghum',
    'nameSo': 'Hadhuudh',
    'unitEn': '50kg Sack',
    'unitSo': 'Kiish 50kg',
    'price': 30.0,
    'changePercent': -0.5,
    'imageAsset': 'assets/images/sorghum.jpg',
    'category': 'grains',
  },
  {
    'id': 'maize',
    'nameEn': 'Maize (Corn)',
    'nameSo': 'Galley',
    'unitEn': '50kg Sack',
    'unitSo': 'Kiish 50kg',
    'price': 28.0,
    'changePercent': 1.2,
    'imageAsset': 'assets/images/maize.jpg',
    'category': 'grains',
  },
  {
    'id': 'cumin',
    'nameEn': 'Cumin',
    'nameSo': 'Xawaash',
    'unitEn': '100g',
    'unitSo': '100g',
    'price': 3.5,
    'changePercent': 2.0,
    'imageAsset': 'assets/images/cumin.jpg',
    'category': 'spices',
  },
];

const List<String> _cities = [
  'Hargeisa',
  'Burco',
  'Berbera',
  'Wajaale',
  'Gebiley',
  'Boorama',
];

double _priceFactorFor(String city) {
  switch (city) {
    case 'Burco':
      return 0.9;
    case 'Berbera':
      return 1.1;
    case 'Wajaale':
      return 0.85;
    case 'Gebiley':
      return 0.95;
    case 'Boorama':
      return 1.05;
    default:
      return 1.0; // Hargeisa
  }
}

void main() async {
  print('⏳ Isku xirid Firebase...');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final db = FirebaseFirestore.instance;
  final batch = db.batch();
  var count = 0;

  for (final city in _cities) {
    final priceFactor = _priceFactorFor(city);

    for (final item in _baseItems) {
      final baseChange = item['changePercent'] as double;
      final change = baseChange * (0.8 + 0.4 * (city.hashCode % 5) / 5);

      final docId = '${item['id']}_$city';
      final docRef = db.collection('market_prices').doc(docId);

      batch.set(docRef, {
        'nameEn': item['nameEn'],
        'nameSo': item['nameSo'],
        'unitEn': item['unitEn'],
        'unitSo': item['unitSo'],
        'price': (item['price'] as double) * priceFactor,
        'changePercent': change,
        'imageAsset': item['imageAsset'],
        'category': item['category'],
        'city': city,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      count++;
    }
  }

  print('⏳ Diritaanka $count documents Firestore...');
  await batch.commit();
  print('✅ Dhammaystirmay! $count alaab ayaa lagu daray market_prices, '
      'lixda magaalo oo dhan.');
}
