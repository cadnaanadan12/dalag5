// lib/widgets/city_selector_sheet.dart
//
// Bottom sheet la wadaago (Home + Settings) si loo doorto magaalada.
// Marka magaalo la doorto, wuxuu cusboonaysiiyaa CityProvider IYO
// MarketDataProvider (si alaabta la muujiyo ay isla markiiba u bedesho).

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/city.dart';
import '../providers/city_provider.dart';
import '../providers/language_provider.dart';
import '../providers/market_data_provider.dart';
import '../theme/app_theme.dart';

void showCitySelector(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (sheetContext) {
      return Consumer2<LanguageProvider, CityProvider>(
        builder: (context, lang, cityProvider, _) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Text(
                  lang.t('select_preferred_city'),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 16),
                ...availableCities.map((c) {
                  final selected = cityProvider.currentCity.id == c.id;
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      backgroundColor:
                          selected ? AppColors.primaryGreen : AppColors.beige,
                      child: Icon(Icons.location_city,
                          color: selected ? Colors.white : AppColors.textDark,
                          size: 18),
                    ),
                    title: Text(c.name,
                        style: TextStyle(
                            fontWeight:
                                selected ? FontWeight.w700 : FontWeight.w500)),
                    trailing: selected
                        ? const Icon(Icons.check_circle,
                            color: AppColors.primaryGreen)
                        : null,
                    onTap: () {
                      context.read<CityProvider>().setCity(c);
                      context.read<MarketDataProvider>().updateCity(c.name);
                      Navigator.pop(context);
                    },
                  );
                }),
              ],
            ),
          );
        },
      );
    },
  );
}
