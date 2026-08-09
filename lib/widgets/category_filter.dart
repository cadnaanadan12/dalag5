import 'package:flutter/material.dart';

import '../models/price_item.dart';
import '../theme/app_theme.dart';

class CategoryFilter extends StatelessWidget {
  final Category? selectedCategory;
  final ValueChanged<Category?> onCategorySelected;

  const CategoryFilter({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = Category.values;
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length + 1,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isAll = index == 0;
          final category = isAll ? null : categories[index - 1];
          final selected = selectedCategory == category;
          final label =
              isAll ? 'All' : (category!.nameEn); // You can use localization
          return ChoiceChip(
            label: Text(label),
            selected: selected,
            onSelected: (_) => onCategorySelected(category),
            selectedColor: AppColors.primaryGreen,
            backgroundColor: AppColors.beige,
            labelStyle: TextStyle(
              color: selected ? Colors.white : AppColors.textDark,
              fontWeight: FontWeight.w600,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            side: BorderSide.none,
          );
        },
      ),
    );
  }
}
