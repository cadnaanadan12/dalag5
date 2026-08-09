import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/price_item.dart';
import '../providers/city_provider.dart';
import '../providers/language_provider.dart';
import '../providers/market_data_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/category_filter.dart';
import '../widgets/produce_image.dart';
import 'add_price_screen.dart';
import 'analysis_chart_screen.dart';
import 'home_screen.dart';
import 'settings_screen.dart';

class MarketsScreen extends StatefulWidget {
  const MarketsScreen({super.key});

  @override
  State<MarketsScreen> createState() => _MarketsScreenState();
}

class _MarketsScreenState extends State<MarketsScreen> {
  Category? _selectedCategory;
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    if (index == 1) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) {
          switch (index) {
            case 0:
              return const HomeScreen();
            case 2:
              return const AddPriceScreen();
            default:
              return const SettingsScreen();
          }
        },
      ),
    );
  }

  List<PriceItem> _applyFilters(List<PriceItem> items) {
    var result = items;
    if (_selectedCategory != null) {
      result =
          result.where((item) => item.category == _selectedCategory).toList();
    }
    if (_query.trim().isNotEmpty) {
      final q = _query.trim().toLowerCase();
      result = result
          .where((item) =>
              item.nameEn.toLowerCase().contains(q) ||
              item.nameSo.toLowerCase().contains(q))
          .toList();
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final marketProvider = context.watch<MarketDataProvider>();
    final cityProvider = context.watch<CityProvider>();
    final somali = lang.isSomali;
    final currentCity = cityProvider.currentCity.name;
    final allItems = marketProvider.items;
    final filteredItems = _applyFilters(allItems);
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
      bottomNavigationBar: DalagBottomNav(currentIndex: 1, onTap: _onNavTap),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                lang.t('live_market_rates'),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkChip : AppColors.beige,
                  borderRadius: BorderRadius.circular(14),
                ),
                child:
                    Text(lang.t('today'), style: const TextStyle(fontSize: 11)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Icon(Icons.location_on,
                  size: 16, color: AppColors.primaryGreen),
              const SizedBox(width: 4),
              Text(currentCity,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 16)),
              const Spacer(),
              Text(
                '${filteredItems.length} ${lang.t('items_count')}',
                style: TextStyle(
                    color: isDark ? AppColors.darkGrey : AppColors.textGrey,
                    fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 12),
          CategoryFilter(
            selectedCategory: _selectedCategory,
            onCategorySelected: (cat) =>
                setState(() => _selectedCategory = cat),
          ),
          const SizedBox(height: 16),

          // Search - hadda si dhab ah ayay u shaqaynaysaa
          TextField(
            controller: _searchController,
            onChanged: (value) => setState(() => _query = value),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: lang.t('search_vegetables'),
              suffixIcon: _query.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        _searchController.clear();
                        setState(() => _query = '');
                      },
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 16),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text(lang.t('produce'), style: _headerStyle)),
                      Expanded(
                          flex: 2,
                          child: Text(lang.t('unit'), style: _headerStyle)),
                      Expanded(
                        flex: 2,
                        child: Text(lang.t('price_slsh'),
                            style: _headerStyle, textAlign: TextAlign.end),
                      ),
                    ],
                  ),
                  const Divider(),
                  if (filteredItems.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          somali ? 'Wax lama helin' : 'No results found',
                          style: TextStyle(
                              color: isDark
                                  ? AppColors.darkGrey
                                  : AppColors.textGrey),
                        ),
                      ),
                    )
                  else
                    ...filteredItems.map((item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Row(
                                  children: [
                                    ProduceImage(
                                      assetPath: item.imageAsset,
                                      fallbackIcon: item.fallbackIcon,
                                      size: 40,
                                      borderRadius: 10,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(item.nameEn,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600)),
                                          Text(
                                            item.name(somali),
                                            style: TextStyle(
                                              color: isDark
                                                  ? AppColors.darkGrey
                                                  : AppColors.textGrey,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(flex: 2, child: Text(item.unit(somali))),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      item.priceLabel,
                                      style: TextStyle(
                                        color: isDark
                                            ? AppColors.darkPositive
                                            : AppColors.positive,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      item.changePercent == 0
                                          ? lang.t('stable')
                                          : item.changeLabel,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: item.isUp
                                            ? (isDark
                                                ? AppColors.darkNegative
                                                : AppColors.negative)
                                            : item.isDown
                                                ? (isDark
                                                    ? AppColors.darkPositive
                                                    : AppColors.positive)
                                                : (isDark
                                                    ? AppColors.darkGrey
                                                    : AppColors.textGrey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),

          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lang.t('market_sentiment'),
                  style: const TextStyle(
                      color: Colors.white70, fontSize: 11, letterSpacing: 1),
                ),
                const SizedBox(height: 8),
                Text(
                  lang.t('sentiment_text').replaceAll('%city', currentCity),
                  style: const TextStyle(color: Colors.white, height: 1.4),
                ),
                const SizedBox(height: 14),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primaryGreen,
                    minimumSize: const Size(140, 44),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AnalysisChartScreen()));
                  },
                  child: Text(lang.t('view_analysis')),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Price Comparison - hadda way la jaan qaadaan Dark Mode
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkChip : AppColors.beige,
              borderRadius: BorderRadius.circular(16),
              border: isDark ? Border.all(color: AppColors.darkBorder) : null,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lang.t('price_comparison'),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: isDark ? AppColors.darkText : AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 12),
                _comparisonRow(
                    somali ? 'Yaanyo' : 'Tomatoes', '9,200', '8,800', isDark),
                const SizedBox(height: 10),
                _comparisonRow(
                    somali ? 'Basal' : 'Onions', '6,000', '6,500', isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static const _headerStyle = TextStyle(
    color: AppColors.textGrey,
    fontSize: 11,
    fontWeight: FontWeight.w600,
  );

  Widget _comparisonRow(
      String name, String burco, String berbera, bool isDark) {
    final labelColor = isDark ? AppColors.darkGrey : AppColors.textGrey;
    final valueColor = isDark ? AppColors.darkText : AppColors.textDark;
    return Row(
      children: [
        Expanded(
          child: Text(name,
              style: TextStyle(fontWeight: FontWeight.w600, color: valueColor)),
        ),
        Expanded(
          child: Column(
            children: [
              Text('Burco', style: TextStyle(fontSize: 10, color: labelColor)),
              Text(burco, style: TextStyle(color: valueColor)),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Text('Berbera',
                  style: TextStyle(fontSize: 10, color: labelColor)),
              Text(berbera, style: TextStyle(color: valueColor)),
            ],
          ),
        ),
      ],
    );
  }
}
