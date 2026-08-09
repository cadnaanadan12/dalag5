import 'package:flutter/material.dart';

enum Category { vegetables, fruits, grains, oils, poultry, spices }

extension CategoryExtension on Category {
  String get nameEn {
    switch (this) {
      case Category.vegetables:
        return 'Vegetables';
      case Category.fruits:
        return 'Fruits';
      case Category.grains:
        return 'Grains';
      case Category.oils:
        return 'Oils';
      case Category.poultry:
        return 'Poultry';
      case Category.spices:
        return 'Spices';
    }
  }

  String get nameSo {
    switch (this) {
      case Category.vegetables:
        return 'Khudaar';
      case Category.fruits:
        return 'Fruit';
      case Category.grains:
        return 'Hadhuudh';
      case Category.oils:
        return 'Saliid';
      case Category.poultry:
        return 'Digaag';
      case Category.spices:
        return 'Xawaash';
    }
  }
}

class PriceItem {
  final String id; // unique
  final String nameEn;
  final String nameSo;
  final String unitEn;
  final String unitSo;
  final double price; // numeric price
  final double changePercent;
  final String imageAsset;
  final IconData fallbackIcon;
  final Category category;
  final String city; // which city this price applies to

  PriceItem({
    required this.id,
    required this.nameEn,
    required this.nameSo,
    required this.unitEn,
    required this.unitSo,
    required this.price,
    required this.changePercent,
    required this.imageAsset,
    this.fallbackIcon = Icons.eco,
    required this.category,
    required this.city,
  });

  String get priceLabel => '\$${price.toStringAsFixed(2)}'; // or SLSH

  String name(bool somali) => somali ? nameSo : nameEn;
  String unit(bool somali) => somali ? unitSo : unitEn;

  bool get isUp => changePercent > 0;
  bool get isDown => changePercent < 0;

  String get changeLabel {
    if (changePercent == 0) return '0.0%';
    final sign = changePercent > 0 ? '+' : '';
    return '$sign${changePercent.toStringAsFixed(1)}%';
  }
}
