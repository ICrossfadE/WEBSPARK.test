import 'package:flutter/material.dart';
import 'package:webspark_test/constants/styles.dart';
import 'package:webspark_test/models/result_model.dart';

class GridVisualization {
  final List<String> field;
  final List<Point> steps;

  const GridVisualization({
    required this.field,
    required this.steps,
  });

  List<List<Widget>> _generateGrid() {
    _validateGridSize();

    final List<List<Widget>> gridCells = [];
    final int rows = field.length;
    final int cols = field[0].length;

    //Map для швидкого пошуку точок шляху
    final Map<String, bool> pathPoints = {};
    for (var step in steps) {
      pathPoints['${step.x},${step.y}'] = true;
    }

    // Проходимо по всіх клітинках та визначаємо їх колір
    for (int i = 0; i < rows; i++) {
      List<Widget> rowCells = [];
      for (int j = 0; j < cols; j++) {
        Color cellColor = kEmptyPathColor;

        // Заблокована клітинка
        if (field[i][j] == 'X') {
          cellColor = kBlokedPathColor;
        } else if (pathPoints.containsKey('$j,$i')) {
          // Початкова точка
          if (j == int.parse(steps.first.x) && i == int.parse(steps.first.y)) {
            cellColor = kStartPathColor;
          }
          // Кінцева точка
          else if (j == int.parse(steps.last.x) &&
              i == int.parse(steps.last.y)) {
            cellColor = kEndPathColor;
          }
          // Точка шляху
          else {
            cellColor = kShortPathColor;
          }
        }

        // Створення віджету клітинки
        rowCells.add(
          Expanded(
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: cellColor,
                  border: Border.all(color: Colors.black12),
                ),
                child: Center(
                  child: Text(
                    '($j,$i)',
                    style: TextStyle(
                      fontSize: 12,
                      color: cellColor == kBlokedPathColor
                          ? Colors.white
                          : Colors.black54,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
      gridCells.add(rowCells);
    }
    return gridCells;
  }

  void _validateGridSize() {
    if (field.isEmpty || field[0].isEmpty) {
      print('Grid size must be greater than 1');
    }

    final int rows = field.length;
    final int cols = field[0].length;

    if (rows >= 100 || cols >= 100) {
      print('Grid size must be less than 100');
    }

    if (rows < 2 || cols < 2) {
      print('Grid size must be greater than 1');
    }

    // Перевірка, що всі рядки мають однакову довжину
    if (field.any((row) => row.length != cols)) {
      print('All rows must have the same length');
    }
  }

  Widget buildGrid() {
    final gridCells = _generateGrid();

    return Column(
      children: gridCells.map((row) => Row(children: row)).toList(),
    );
  }
}
