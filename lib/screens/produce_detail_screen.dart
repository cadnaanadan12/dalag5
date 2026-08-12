// lib/screens/produce_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/price_item.dart';
import '../providers/language_provider.dart';
import '../providers/market_data_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/produce_image.dart';

class ProduceDetailScreen extends StatelessWidget {
  final PriceItem item;
  const ProduceDetailScreen({super.key, required this.item});

  Future<void> _confirmDelete(BuildContext context) async {
    final lang = context.read<LanguageProvider>();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(lang.t('delete_confirm_title')),
        content: Text(lang.t('delete_confirm_body')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(lang.t('cancel')),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: Text(lang.t('delete')),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await context.read<MarketDataProvider>().deletePriceItem(item.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(lang.t('item_deleted'))),
        );
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final somali = lang.isSomali;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final Color changeColor = item.isUp
        ? (isDark ? AppColors.darkNegative : AppColors.negative)
        : item.isDown
            ? (isDark ? AppColors.darkPositive : AppColors.positive)
            : (isDark ? AppColors.darkGrey : AppColors.textGrey);

    return Scaffold(
      appBar: AppBar(
        title: Text(lang.t('produce_details')),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppColors.danger),
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: ProduceImage(
              assetPath: item.imageAsset,
              fallbackIcon: item.fallbackIcon,
              size: 140,
              borderRadius: 24,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            item.name(somali),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 4),
          Text(
            item.unit(somali),
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.textGrey, fontSize: 14),
          ),
          const SizedBox(height: 24),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _row(lang.t('current_price'), item.priceLabel,
                      valueColor: AppColors.positive, big: true),
                  const Divider(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(lang.t('change'),
                          style: const TextStyle(
                              color: AppColors.textGrey, fontSize: 12)),
                      Row(
                        children: [
                          Icon(
                            item.isUp
                                ? Icons.trending_up
                                : item.isDown
                                    ? Icons.trending_down
                                    : Icons.remove,
                            size: 16,
                            color: changeColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item.changePercent == 0
                                ? lang.t('stable')
                                : item.changeLabel,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: changeColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(height: 28),
                  _row(lang.t('category'),
                      somali ? item.category.nameSo : item.category.nameEn),
                  const Divider(height: 28),
                  _row(lang.t('city'), item.city),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.danger,
              side: const BorderSide(color: AppColors.danger),
            ),
            icon: const Icon(Icons.delete_outline),
            label: Text(lang.t('delete')),
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
    );
  }

  Widget _row(String label, String value,
      {Color? valueColor, bool big = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(color: AppColors.textGrey, fontSize: 12)),
        Text(
          value,
          style: TextStyle(
            fontSize: big ? 22 : 15,
            fontWeight: big ? FontWeight.w800 : FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
