import '../models/price_item.dart';

class MarketDataService {
  static List<PriceItem> getDataForCity(String cityName) {
    // Generate dummy data per city
    // For demo, we vary prices slightly per city
    final baseItems = _baseItems;
    return baseItems.map((item) {
      // Vary price and change based on city
      double priceFactor = 1.0;
      if (cityName == 'Burco')
        priceFactor = 0.9;
      else if (cityName == 'Berbera')
        priceFactor = 1.1;
      else if (cityName == 'Wajaale')
        priceFactor = 0.85;
      else if (cityName == 'Gebiley')
        priceFactor = 0.95;
      else if (cityName == 'Boorama') priceFactor = 1.05;
      // random change
      double change =
          (item.changePercent * (0.8 + 0.4 * (cityName.hashCode % 5) / 5));
      return PriceItem(
        id: '${item.id}_$cityName',
        nameEn: item.nameEn,
        nameSo: item.nameSo,
        unitEn: item.unitEn,
        unitSo: item.unitSo,
        price: item.price * priceFactor,
        changePercent: change,
        imageAsset: item.imageAsset,
        fallbackIcon: item.fallbackIcon,
        category: item.category,
        city: cityName,
      );
    }).toList();
  }

  static final List<PriceItem> _baseItems = [
    PriceItem(
      id: 'tomato',
      nameEn: 'Tomatoes',
      nameSo: 'Yaanyo',
      unitEn: '1kg',
      unitSo: '1kg',
      price: 8.5,
      changePercent: 2.4,
      imageAsset: 'assets/images/tomato.jpg',
      category: Category.vegetables,
      city: 'Hargeisa',
    ),
    PriceItem(
      id: 'onion',
      nameEn: 'Onions',
      nameSo: 'Basal',
      unitEn: '1kg',
      unitSo: '1kg',
      price: 6.2,
      changePercent: -1.2,
      imageAsset: 'assets/images/onion.jpg',
      category: Category.vegetables,
      city: 'Hargeisa',
    ),
    PriceItem(
      id: 'potato',
      nameEn: 'Potatoes',
      nameSo: 'Baradhada',
      unitEn: '1kg',
      unitSo: '1kg',
      price: 5.4,
      changePercent: 0.0,
      imageAsset: 'assets/images/potato.jpg',
      category: Category.vegetables,
      city: 'Hargeisa',
    ),
    PriceItem(
      id: 'pepper',
      nameEn: 'Peppers',
      nameSo: 'Basbaas',
      unitEn: 'Bag (S)',
      unitSo: 'Bag (S)',
      price: 12.0,
      changePercent: 5.8,
      imageAsset: 'assets/images/pepper.jpg',
      category: Category.vegetables,
      city: 'Hargeisa',
    ),
    PriceItem(
      id: 'carrot',
      nameEn: 'Carrots',
      nameSo: 'Karooto',
      unitEn: 'Bundle',
      unitSo: 'Xidhmo',
      price: 7.5,
      changePercent: -3.1,
      imageAsset: 'assets/images/carrot.jpg',
      category: Category.vegetables,
      city: 'Hargeisa',
    ),
    PriceItem(
      id: 'watermelon',
      nameEn: 'Watermelon',
      nameSo: 'Qarre',
      unitEn: 'Piece',
      unitSo: 'Xabbad',
      price: 25.0,
      changePercent: 0.0,
      imageAsset: 'assets/images/watermelon.jpg',
      category: Category.fruits,
      city: 'Hargeisa',
    ),
    PriceItem(
      id: 'mango',
      nameEn: 'Mango',
      nameSo: 'Mango',
      unitEn: '1kg',
      unitSo: '1kg',
      price: 12.0,
      changePercent: 3.2,
      imageAsset: 'assets/images/mango.jpg',
      category: Category.fruits,
      city: 'Hargeisa',
    ),
    PriceItem(
      id: 'sorghum',
      nameEn: 'Sorghum',
      nameSo: 'Hadhuudh',
      unitEn: '50kg Sack',
      unitSo: 'Kiish 50kg',
      price: 30.0,
      changePercent: -0.5,
      imageAsset: 'assets/images/sorghum.jpg',
      category: Category.grains,
      city: 'Hargeisa',
    ),
    PriceItem(
      id: 'oil',
      nameEn: 'Cooking Oil',
      nameSo: 'Saliid',
      unitEn: '5L',
      unitSo: '5L',
      price: 18.0,
      changePercent: 1.1,
      imageAsset: 'assets/images/oil.jpg',
      category: Category.oils,
      city: 'Hargeisa',
    ),
    PriceItem(
      id: 'chicken',
      nameEn: 'Chicken (local)',
      nameSo: 'Digaag',
      unitEn: 'Piece',
      unitSo: 'Xabbad',
      price: 8.0,
      changePercent: 0.8,
      imageAsset: 'assets/images/chicken.jpg',
      category: Category.poultry,
      city: 'Hargeisa',
    ),
    PriceItem(
      id: 'cumin',
      nameEn: 'Cumin',
      nameSo: 'Xawaash',
      unitEn: '100g',
      unitSo: '100g',
      price: 3.5,
      changePercent: 2.0,
      imageAsset: 'assets/images/cumin.jpg',
      category: Category.spices,
      city: 'Hargeisa',
    ),
  ];
}
