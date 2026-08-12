// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/price_item.dart';
import '../providers/city_provider.dart';
import '../providers/language_provider.dart';
import '../providers/market_data_provider.dart';
import '../providers/user_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/city_selector_sheet.dart';
import '../widgets/item_detail_sheet.dart';
import '../widgets/price_card.dart';
import 'add_price_screen.dart';
import 'markets_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    if (index == _navIndex) return;
    switch (index) {
      case 0:
        setState(() => _navIndex = 0);
        break;
      case 1:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const MarketsScreen()));
        break;
      case 2:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const AddPriceScreen()));
        break;
      case 3:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const SettingsScreen()));
        break;
    }
  }

  List<PriceItem> _filter(List<PriceItem> items, bool somali) {
    if (_query.trim().isEmpty) return items;
    final q = _query.trim().toLowerCase();
    return items.where((item) {
      return item.nameEn.toLowerCase().contains(q) ||
          item.nameSo.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final user = context.watch<UserProvider>();
    final cityProvider = context.watch<CityProvider>();
    final marketProvider = context.watch<MarketDataProvider>();
    final somali = lang.isSomali;
    final currentCity = cityProvider.currentCity.name;
    final allItems = marketProvider.items;
    final filteredItems = _filter(allItems, somali);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.agriculture, color: AppColors.primaryGreen),
            const SizedBox(width: 6),
            const Text('Dalag'),
          ],
        ),
        actions: [
          // Taabashadan hadda waxay furaysaa doorashada magaalada.
          GestureDetector(
            onTap: () => showCitySelector(context),
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkChip : AppColors.beige,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.location_city,
                      size: 16,
                      color:
                          isDark ? AppColors.darkAccent : AppColors.textDark),
                  const SizedBox(width: 4),
                  Text(currentCity),
                  const SizedBox(width: 2),
                  Icon(Icons.keyboard_arrow_down,
                      size: 16,
                      color:
                          isDark ? AppColors.darkAccent : AppColors.textDark),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryGreen,
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const AddPriceScreen())),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar:
          DalagBottomNav(currentIndex: _navIndex, onTap: _onNavTap),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lang.t('welcome_back_caps'),
                  style: const TextStyle(
                      color: Colors.white70, fontSize: 12, letterSpacing: 1),
                ),
                const SizedBox(height: 4),
                Text(
                  user.user?.name ?? lang.t('guest'),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 6),
                Text(
                  lang.t('market_stable').replaceAll('%city', currentCity),
                  style: const TextStyle(color: Colors.white, height: 1.3),
                ),
                const SizedBox(height: 16),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.wb_sunny, color: Colors.amberAccent),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lang.t('daily_forecast'),
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 10),
                          ),
                          const Text(
                            '32°C',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

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
          const SizedBox(height: 22),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _query.isEmpty
                    ? lang.t('trending_prices')
                    : '${lang.t('search_vegetables')} (${filteredItems.length})',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              if (_query.isEmpty)
                TextButton(
                  onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const MarketsScreen())),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(lang.t('view_all'),
                          style:
                              const TextStyle(color: AppColors.primaryGreen)),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_forward,
                          size: 16, color: AppColors.primaryGreen),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),

          if (filteredItems.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Text(
                  lang.isSomali ? 'Wax lama helin' : 'No results found',
                  style: const TextStyle(color: AppColors.textGrey),
                ),
              ),
            )
          else
            ...filteredItems
                .take(_query.isEmpty ? 3 : filteredItems.length)
                .map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: TrendingPriceCard(
                      item: item,
                      onTap: () => showItemDetailSheet(context, item),
                    ),
                  ),
                ),

          if (_query.isEmpty) ...[
            const SizedBox(height: 8),
            Text(
              lang.t('market_activity'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(lang.t('item'), style: _headerStyle)),
                        Expanded(
                            child: Text(lang.t('unit'), style: _headerStyle)),
                        Expanded(
                            child: Text(lang.t('price'), style: _headerStyle)),
                        Expanded(
                            child: Text(lang.t('change'),
                                style: _headerStyle, textAlign: TextAlign.end)),
                      ],
                    ),
                    const Divider(),
                    ...allItems.take(3).map((item) => InkWell(
                          onTap: () => showItemDetailSheet(context, item),
                          child: _activityRow(item, lang, somali),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  static const _headerStyle = TextStyle(
    color: AppColors.textGrey,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );

  Widget _activityRow(PriceItem item, LanguageProvider lang, bool somali) {
    final color = item.isUp
        ? AppColors.negative
        : (item.isDown ? AppColors.positive : AppColors.textGrey);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Text(item.name(somali),
                  style: const TextStyle(fontWeight: FontWeight.w600))),
          Expanded(
              child: Text(item.unit(somali),
                  style: const TextStyle(color: AppColors.textGrey))),
          Expanded(child: Text(item.priceLabel)),
          Expanded(
            child: Text(
              item.changePercent == 0 ? lang.t('stable') : item.changeLabel,
              textAlign: TextAlign.end,
              style: TextStyle(color: color, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  void showItemDetailSheet(BuildContext context, PriceItem item) {}
}
