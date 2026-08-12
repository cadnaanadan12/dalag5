// lib/screens/analysis_chart_screen.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/city_provider.dart';
import '../providers/language_provider.dart';
import '../theme/app_theme.dart';

class AnalysisChartScreen extends StatelessWidget {
  const AnalysisChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final city = context.watch<CityProvider>().currentCity.name;

    final List<double> prices = [12.5, 11.8, 12.2, 13.1, 12.9, 13.5, 14.0];
    final List<String> dayKeys = [
      'mon',
      'tue',
      'wed',
      'thu',
      'fri',
      'sat',
      'sun'
    ];

    final double current = prices.last;
    final double first = prices.first;
    final double high = prices.reduce((a, b) => a > b ? a : b);
    final double low = prices.reduce((a, b) => a < b ? a : b);
    final double changePct = ((current - first) / first) * 100;
    final bool isUp = changePct >= 0;
    final Color trendColor = isUp
        ? (isDark ? AppColors.darkNegative : AppColors.negative)
        : (isDark ? AppColors.darkPositive : AppColors.positive);
    final Color accent = isDark ? AppColors.darkAccent : AppColors.primaryGreen;

    return Scaffold(
      appBar: AppBar(title: Text(lang.t('price_trend_title'))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [accent, accent.withOpacity(0.75)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lang.t('price_trend_caption').replaceAll('%city', city),
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${current.toStringAsFixed(2)}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(isUp ? Icons.trending_up : Icons.trending_down,
                          color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${isUp ? '+' : ''}${changePct.toStringAsFixed(1)}%',
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Chart card
          Card(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 20, 12),
              child: SizedBox(
                height: 240,
                child: LineChart(
                  LineChartData(
                    minY: (low - 1).clamp(0, double.infinity),
                    maxY: high + 1,
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: 1,
                      getDrawingHorizontalLine: (_) => FlLine(
                        color: isDark
                            ? AppColors.darkBorder
                            : Colors.grey.withOpacity(0.15),
                        strokeWidth: 1,
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 34,
                          interval: 1,
                          getTitlesWidget: (value, meta) => Text(
                            value.toStringAsFixed(0),
                            style: TextStyle(
                                fontSize: 11,
                                color: isDark
                                    ? AppColors.darkGrey
                                    : AppColors.textGrey),
                          ),
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            final i = value.toInt();
                            if (i < 0 || i >= dayKeys.length) {
                              return const SizedBox();
                            }
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                lang.t(dayKeys[i]),
                                style: TextStyle(
                                    fontSize: 11,
                                    color: isDark
                                        ? AppColors.darkGrey
                                        : AppColors.textGrey),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        getTooltipColor: (_) => accent,
                        getTooltipItems: (spots) => spots.map((s) {
                          return LineTooltipItem(
                            '\$${s.y.toStringAsFixed(2)}',
                            const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          );
                        }).toList(),
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: List.generate(prices.length,
                            (i) => FlSpot(i.toDouble(), prices[i])),
                        isCurved: true,
                        color: accent,
                        barWidth: 3,
                        dotData: FlDotData(
                          show: true,
                          getDotPainter: (spot, percent, bar, index) =>
                              FlDotCirclePainter(
                            radius: 4,
                            color: Colors.white,
                            strokeWidth: 3,
                            strokeColor: accent,
                          ),
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: [
                              accent.withOpacity(0.28),
                              accent.withOpacity(0.0)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Stat cards
          Row(
            children: [
              Expanded(
                child: _statCard(
                  context,
                  icon: Icons.arrow_upward,
                  label: lang.t('high'),
                  value: '\$${high.toStringAsFixed(2)}',
                  color: isDark ? AppColors.darkNegative : AppColors.negative,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _statCard(
                  context,
                  icon: Icons.arrow_downward,
                  label: lang.t('low'),
                  value: '\$${low.toStringAsFixed(2)}',
                  color: isDark ? AppColors.darkPositive : AppColors.positive,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _statCard(
                  context,
                  icon: Icons.percent,
                  label: lang.t('weekly_change'),
                  value: '${isUp ? '+' : ''}${changePct.toStringAsFixed(1)}%',
                  color: trendColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: isDark ? Border.all(color: AppColors.darkBorder) : null,
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(height: 6),
          Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.w800, color: color, fontSize: 15)),
          const SizedBox(height: 2),
          Text(label,
              style: TextStyle(
                  fontSize: 11,
                  color: isDark ? AppColors.darkGrey : AppColors.textGrey)),
        ],
      ),
    );
  }
}
