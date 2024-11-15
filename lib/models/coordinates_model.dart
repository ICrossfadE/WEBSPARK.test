abstract class BaseCoordinates {
  int get x;
  int get y;

  Map<String, dynamic> toJson();
}

// Клас для вхідних координат
class Coordinates extends BaseCoordinates {
  @override
  final int x;
  @override
  final int y;

  Coordinates({
    required this.x,
    required this.y,
  });

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      x: json['x'] as int,
      y: json['y'] as int,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        "x": x.toString(),
        "y": y.toString(),
      };

  // Конвертація в Points для API
  Points toPoints() => Points(
        x: x.toString(),
        y: y.toString(),
      );
}

// Клас для вихідних координат (API формат)
class Points {
  final String x;
  final String y;

  Points({
    required this.x,
    required this.y,
  });

  Map<String, String> toJson() => {
        "x": x,
        "y": y,
      };

  // Конвертація в Coordinates
  Coordinates toCoordinates() => Coordinates(
        x: int.parse(x),
        y: int.parse(y),
      );
}

// Вхідна модель
class InputModel {
  final String id;
  final List<String> field;
  final Coordinates start;
  final Coordinates end;

  InputModel({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  factory InputModel.fromJson(Map<String, dynamic> json) {
    return InputModel(
      id: json['id'],
      field: (json['field'] as List<dynamic>).map((e) => e as String).toList(),
      start: Coordinates.fromJson(json['start'] as Map<String, dynamic>),
      end: Coordinates.fromJson(json['end'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "field": field,
        "start": start.toJson(),
        "end": end.toJson(),
      };
}
