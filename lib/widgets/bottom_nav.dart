import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/language_provider.dart';
import '../theme/app_theme.dart';

/// Bottom navigation-ka lagu isticmaalo afarta bog ee ugu weyn:
/// Home, Markets, Add, Settings.
/// Midabadeeda hadda way la jaan qaadaan Dark Mode / Light Mode.
class DalagBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const DalagBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final backgroundColor = isDark ? AppColors.darkCard : Colors.white;
    final selectedChipColor = isDark ? AppColors.darkChip : AppColors.beige;
    final selectedColor =
        isDark ? AppColors.darkAccent : AppColors.primaryGreen;
    final unselectedColor = isDark ? AppColors.darkGrey : AppColors.textGrey;
    final shadowColor =
        isDark ? Colors.black.withOpacity(0.4) : Colors.black.withOpacity(0.06);

    final items = [
      (Icons.home_rounded, lang.t('home')),
      (Icons.storefront_rounded, lang.t('markets')),
      (Icons.add_circle, lang.t('add')),
      (Icons.settings_rounded, lang.t('settings')),
    ];

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: isDark
            ? const Border(
                top: BorderSide(color: AppColors.darkBorder, width: 1))
            : null,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final selected = currentIndex == index;
            final (icon, label) = items[index];
            return InkWell(
              onTap: () => onTap(index),
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: selected ? selectedChipColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      icon,
                      color: selected ? selectedColor : unselectedColor,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                            selected ? FontWeight.w600 : FontWeight.w400,
                        color: selected ? selectedColor : unselectedColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
