import 'package:flutter/material.dart';
import 'package:webspark_test/constants/styles.dart';
import 'package:webspark_test/services/ApiService.dart';
import 'package:webspark_test/utils/generatorGrid.dart';

class PreviewPage extends StatelessWidget {
  final int? indexPage;
  final ApiService network;

  const PreviewPage({
    super.key,
    required this.network,
    required this.indexPage,
  });

  @override
  Widget build(BuildContext context) {
    final field = network.resultData[indexPage!].field;
    final steps = network.solutions[indexPage!].steps;
    final path = network.solutions[indexPage!].path;

    final GridVisualization gridVisualization = GridVisualization(
      field: field,
      steps: steps,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview page'),
        backgroundColor: kAppBarColor,
      ),
      body: Column(
        children: [
          gridVisualization.buildGrid(),
          Text(path, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
