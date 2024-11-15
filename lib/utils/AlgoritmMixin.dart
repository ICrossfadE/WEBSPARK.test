import 'package:webspark_test/models/coordinates_model.dart';
import 'package:webspark_test/models/result_model.dart';

mixin AlgorithmMixin {
  Future<Result> findShortestPath(InputModel input) async {
    try {
      final grid = input.field; // Сітка/поле
      final start = input.start; // Початкова точка
      final end = input.end; // Кінцева точка

      final queue = <List<Coordinates>>[];
      queue.add([start]);

      final visited = <Coordinates>{start};

      while (queue.isNotEmpty) {
        final path = queue.removeAt(0);
        final current = path.last;

        if (current.x == end.x && current.y == end.y) {
          final pathString = path.map((c) => '(${c.x},${c.y})').join('->');
          final points = path
              .map((coord) =>
                  Point(x: coord.x.toString(), y: coord.y.toString()))
              .toList();

          return Result(id: input.id, steps: points, path: pathString);
        }

        for (final neighbor in [
          // Напрямки руху
          Coordinates(x: current.x - 1, y: current.y),
          Coordinates(x: current.x + 1, y: current.y),
          Coordinates(x: current.x, y: current.y - 1),
          Coordinates(x: current.x, y: current.y + 1),
          Coordinates(x: current.x - 1, y: current.y - 1),
          Coordinates(x: current.x + 1, y: current.y + 1),
          Coordinates(x: current.x - 1, y: current.y + 1),
          Coordinates(x: current.x + 1, y: current.y - 1),
        ]) {
          // Перевірка чи не виходимо за межі поля
          if (neighbor.x >= 0 &&
              neighbor.y >= 0 &&
              neighbor.x < grid[0].length &&
              neighbor.y < grid.length &&
              grid[neighbor.y][neighbor.x] != 'X' &&
              !visited.contains(neighbor)) {
            visited.add(neighbor);
            queue.add([...path, neighbor]);
          }
        }
      }

      throw Exception('Path not found');
    } catch (e) {
      rethrow;
    }
  }
}
