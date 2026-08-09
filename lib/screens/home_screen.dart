import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/city.dart';
import '../models/price_item.dart';
import '../providers/city_provider.dart';
import '../providers/language_provider.dart';
import '../providers/market_data_provider.dart';
import '../providers/user_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav.dart';
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

  void _onNavTap(int index) {
    if (index == _navIndex) return;
    switch (index) {
      case 0:
        setState(() => _navIndex = 0);
        break;
      case 1:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const MarketsScreen()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const AddPriceScreen()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final user = context.watch<UserProvider>();
    final cityProvider = context.watch<CityProvider>();
    final marketProvider = context.watch<MarketDataProvider>();
    final somali = lang.isSomali;
    final currentCity = cityProvider.currentCity.name;
    final items = marketProvider.items;

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
          DropdownButton<City>(
            value: cityProvider.currentCity,
            underline: const SizedBox(),
            icon: const Icon(Icons.arrow_drop_down,
                color: AppColors.primaryGreen),
            items: availableCities.map((city) {
              return DropdownMenuItem<City>(
                value: city,
                child: Row(
                  children: [
                    const Icon(Icons.location_city, size: 16),
                    const SizedBox(width: 4),
                    Text(city.name),
                  ],
                ),
              );
            }).toList(),
            onChanged: (City? newCity) {
              if (newCity != null) {
                cityProvider.setCity(newCity);
                marketProvider.updateCity(newCity.name);
              }
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryGreen,
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const AddPriceScreen())),
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
                  user.user?.name ?? 'Guest',
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
          TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: lang.t('search_vegetables'),
            ),
          ),
          const SizedBox(height: 22),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                lang.t('trending_prices'),
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              TextButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const MarketsScreen())),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(lang.t('view_all'),
                        style: const TextStyle(color: AppColors.primaryGreen)),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_forward,
                        size: 16, color: AppColors.primaryGreen),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...items.take(3).map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: TrendingPriceCard(item: item),
                ),
              ),
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
                  ...items
                      .take(3)
                      .map((item) => _activityRow(item, lang, somali)),
                ],
              ),
            ),
          ),
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
}
