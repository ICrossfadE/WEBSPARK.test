class Result {
  final String id;
  final List<Point> steps;
  final String path;

  Result({
    required this.id,
    required this.steps,
    required this.path,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'result': {
        'steps': steps.map((step) => step.toJson()).toList(),
        'path': path,
      }
    };
  }
}

class Point {
  final String x;
  final String y;

  Point({required this.x, required this.y});

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
    };
  }
}
