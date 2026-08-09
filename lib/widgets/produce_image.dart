import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Muujiya sawirka khudaarta (asset). Haddii sawirka aan weli ku jirin
/// assets/images/, waxay isku beddeshaa icon si app-ku uusan u jabin.
class ProduceImage extends StatelessWidget {
  final String assetPath;
  final IconData fallbackIcon;
  final double size;
  final double borderRadius;

  const ProduceImage({
    super.key,
    required this.assetPath,
    this.fallbackIcon = Icons.eco,
    this.size = 64,
    this.borderRadius = 14,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        assetPath,
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: size,
            height: size,
            color: AppColors.lightGreenChip,
            child: Icon(
              fallbackIcon,
              color: AppColors.primaryGreen,
              size: size * 0.45,
            ),
          );
        },
      ),
    );
  }
}