import 'package:flutter/material.dart';

class AnalysisChartScreen extends StatelessWidget {
  const AnalysisChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Market Analysis'),
      ),
      body: const Center(
        child: Text('Analysis Chart Content'),
      ),
    );
  }
}
