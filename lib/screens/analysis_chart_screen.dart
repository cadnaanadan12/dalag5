import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/city_provider.dart';
import '../providers/language_provider.dart';

class AnalysisChartScreen extends StatelessWidget {
  const AnalysisChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.watch<LanguageProvider>();
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

    return Scaffold(
      appBar: AppBar(title: Text(lang.t('price_trend_title'))),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 16,
                  barGroups: List.generate(7, (index) {
                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: prices[index],
                          color: Colors.green,
                          width: 20,
                        ),
                      ],
                    );
                  }),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(lang.t(dayKeys[value.toInt()]));
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                  ),
                  gridData: const FlGridData(show: true),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              lang.t('price_trend_caption').replaceAll('%city', city),
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
