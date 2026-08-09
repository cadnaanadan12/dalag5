import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/city.dart';
import '../models/price_item.dart';
import '../providers/language_provider.dart';
import '../providers/market_data_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/produce_image.dart';
import 'home_screen.dart';
import 'markets_screen.dart';
import 'settings_screen.dart';

class AddPriceScreen extends StatefulWidget {
  const AddPriceScreen({super.key});

  @override
  State<AddPriceScreen> createState() => _AddPriceScreenState();
}

class _AddPriceScreenState extends State<AddPriceScreen> {
  int _vegetableIndex = 0;
  int _cityIndex = 0;
  String _unit = 'KG';
  final _priceController = TextEditingController();

  final List<(String, String, IconData, Category)> _vegetables = const [
    (
      'TOMATO',
      'assets/images/tomato.jpg',
      Icons.local_florist,
      Category.vegetables
    ),
    ('ONION', 'assets/images/onion.jpg', Icons.circle, Category.vegetables),
    ('POTATO', 'assets/images/potato.jpg', Icons.circle, Category.vegetables),
    ('PEPPER', 'assets/images/pepper.jpg', Icons.grain, Category.vegetables),
    ('CARROT', 'assets/images/carrot.jpg', Icons.circle, Category.vegetables),
    ('CABBAGE', 'assets/images/cabbage.jpg', Icons.circle, Category.vegetables),
    (
      'CUCUMBER',
      'assets/images/cucumber.jpg',
      Icons.circle,
      Category.vegetables
    ),
    (
      'CHILI',
      'assets/images/chili.jpg',
      Icons.local_fire_department,
      Category.vegetables
    ),
    ('LETTUCE', 'assets/images/lettuce.jpg', Icons.circle, Category.vegetables),
    ('SPINACH', 'assets/images/spinach.jpg', Icons.circle, Category.vegetables),
    (
      'CILANTRO',
      'assets/images/cilantro.jpg',
      Icons.circle,
      Category.vegetables
    ),
    ('PUMPKIN', 'assets/images/pumpkin.jpg', Icons.circle, Category.vegetables),
    (
      'GREEN BEANS',
      'assets/images/greenbeans.jpg',
      Icons.circle,
      Category.vegetables
    ),
    ('PEAS', 'assets/images/peas.jpg', Icons.circle, Category.vegetables),
    (
      'BEETROOT',
      'assets/images/beetroot.jpg',
      Icons.circle,
      Category.vegetables
    ),
    ('OKRA', 'assets/images/okra.jpg', Icons.circle, Category.vegetables),
    ('GARLIC', 'assets/images/garlic.jpg', Icons.circle, Category.vegetables),
    (
      'BROCCOLI',
      'assets/images/broccoli.jpg',
      Icons.circle,
      Category.vegetables
    ),
    (
      'CAULIFLOWER',
      'assets/images/cauliflower.jpg',
      Icons.circle,
      Category.vegetables
    ),
    (
      'WATERMELON',
      'assets/images/watermelon.jpg',
      Icons.circle,
      Category.fruits
    ),
    ('MANGO', 'assets/images/mango.jpg', Icons.circle, Category.fruits),
    ('SORGHUM', 'assets/images/sorghum.jpg', Icons.grain, Category.grains),
    ('MAIZE', 'assets/images/maize.jpg', Icons.grain, Category.grains),
    ('CUMIN', 'assets/images/cumin.jpg', Icons.spa, Category.spices),
  ];

  final _cities = availableCities;
  final _units = const ['KG', 'Bag', 'Sack', 'Box', 'Piece', 'Bundle'];

  void _onNavTap(int index) {
    if (index == 2) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) {
          switch (index) {
            case 0:
              return const HomeScreen();
            case 1:
              return const MarketsScreen();
            default:
              return const SettingsScreen();
          }
        },
      ),
    );
  }

  void _submit() {
    final lang = context.read<LanguageProvider>();
    final priceStr = _priceController.text.trim();
    if (priceStr.isEmpty || double.tryParse(priceStr) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(lang.t('enter_valid_price'))),
      );
      return;
    }
    final price = double.parse(priceStr);
    final selectedCity = _cities[_cityIndex];
    final (nameEn, asset, icon, category) = _vegetables[_vegetableIndex];

    final newItem = PriceItem(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nameEn: nameEn,
      nameSo: nameEn,
      unitEn: _unit,
      unitSo: _unit,
      price: price,
      changePercent: 0.0,
      imageAsset: asset,
      fallbackIcon: icon,
      category: category,
      city: selectedCity.name,
    );

    context.read<MarketDataProvider>().addPriceItem(newItem);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(lang.t('price_submitted'))),
    );
    _priceController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.agriculture, color: AppColors.primaryGreen),
            SizedBox(width: 6),
            Text('Dalag'),
          ],
        ),
      ),
      bottomNavigationBar: DalagBottomNav(currentIndex: 2, onTap: _onNavTap),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Text(lang.t('update_market_price'),
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Text(lang.t('add_subtitle'),
              style: const TextStyle(color: AppColors.textGrey, height: 1.4)),
          const SizedBox(height: 22),
          Text(
            lang.t('select_vegetable'),
            style: const TextStyle(
              color: AppColors.primaryGreen,
              fontWeight: FontWeight.w700,
              fontSize: 12,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(_vegetables.length, (index) {
              final (label, asset, icon, _) = _vegetables[index];
              final selected = index == _vegetableIndex;
              return ChoiceChip(
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ProduceImage(
                        assetPath: asset, fallbackIcon: icon, size: 24),
                    const SizedBox(width: 4),
                    Text(label, style: const TextStyle(fontSize: 12)),
                  ],
                ),
                selected: selected,
                onSelected: (_) => setState(() => _vegetableIndex = index),
                selectedColor: AppColors.primaryGreen,
                backgroundColor: AppColors.beige,
                labelStyle: TextStyle(
                  color: selected ? Colors.white : AppColors.textDark,
                  fontWeight: FontWeight.w600,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                side: BorderSide.none,
              );
            }),
          ),
          const SizedBox(height: 22),
          Text(
            lang.t('market_city'),
            style: const TextStyle(
              color: AppColors.primaryGreen,
              fontWeight: FontWeight.w700,
              fontSize: 12,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(_cities.length, (index) {
              final selected = index == _cityIndex;
              return ChoiceChip(
                label: Text(_cities[index].name),
                selected: selected,
                onSelected: (_) => setState(() => _cityIndex = index),
                selectedColor: AppColors.primaryGreen,
                backgroundColor: AppColors.beige,
                labelStyle: TextStyle(
                  color: selected ? Colors.white : AppColors.textDark,
                  fontWeight: FontWeight.w600,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                side: BorderSide.none,
              );
            }),
          ),
          const SizedBox(height: 22),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lang.t('price_slsh'),
                      style: const TextStyle(
                          color: AppColors.primaryGreen,
                          fontWeight: FontWeight.w700,
                          fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _priceController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(hintText: '0.00'),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lang.t('unit').toUpperCase(),
                      style: const TextStyle(
                          color: AppColors.primaryGreen,
                          fontWeight: FontWeight.w700,
                          fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _unit,
                      items: _units
                          .map(
                              (u) => DropdownMenuItem(value: u, child: Text(u)))
                          .toList(),
                      onChanged: (v) => setState(() => _unit = v ?? _unit),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),
          ElevatedButton.icon(
            onPressed: _submit,
            icon: const Icon(Icons.cloud_upload_outlined),
            label: Text(lang.t('submit_price')),
          ),
        ],
      ),
    );
  }
}
