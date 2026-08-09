import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/price_item.dart';
import '../providers/language_provider.dart';
import '../theme/app_theme.dart';
import 'produce_image.dart';

/// Card-ka waaweyn ee "Trending Prices" bogga Home ku muujiya.
class TrendingPriceCard extends StatelessWidget {
  final PriceItem item;

  const TrendingPriceCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final somali = lang.isSomali;

    final Color badgeColor = item.isUp
        ? AppColors.negative.withOpacity(0.12)
        : item.isDown
        ? AppColors.positive.withOpacity(0.12)
        : Colors.grey.withOpacity(0.15);
    final Color badgeTextColor = item.isUp
        ? AppColors.negative
        : item.isDown
        ? AppColors.positive
        : AppColors.textGrey;
    final IconData badgeIcon = item.isUp
        ? Icons.trending_up
        : item.isDown
        ? Icons.trending_down
        : Icons.remove;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProduceImage(
              assetPath: item.imageAsset,
              fallbackIcon: item.fallbackIcon,
              size: 64,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.name(somali),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: badgeColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(badgeIcon, size: 14, color: badgeTextColor),
                            const SizedBox(width: 2),
                            Text(
                              item.changePercent == 0
                                  ? lang.t('stable')
                                  : item.changeLabel,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: badgeTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.unit(somali),
                    style: const TextStyle(
                        color: AppColors.textGrey, fontSize: 13),
                  ),
                  const Divider(height: 18),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lang.t('current_price'),
                            style: const TextStyle(
                              color: AppColors.textGrey,
                              fontSize: 11,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            item.priceLabel,
                            style: const TextStyle(
                              color: AppColors.positive,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 70,
                        height: 30,
                        child: CustomPaint(
                          painter: _MiniTrendPainter(up: !item.isDown),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Sawir yar oo khadad ah (sparkline) muujinaya isbeddelka qiimaha.
class _MiniTrendPainter extends CustomPainter {
  final bool up;
  _MiniTrendPainter({required this.up});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = up ? AppColors.negative : AppColors.positive
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    final points = up
        ? [0.9, 0.7, 0.75, 0.5, 0.55, 0.2, 0.1]
        : [0.2, 0.35, 0.25, 0.5, 0.45, 0.7, 0.8];

    for (int i = 0; i < points.length; i++) {
      final dx = size.width * (i / (points.length - 1));
      final dy = size.height * points[i];
      if (i == 0) {
        path.moveTo(dx, dy);
      } else {
        path.lineTo(dx, dy);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _MiniTrendPainter oldDelegate) =>
      oldDelegate.up != up;
}