class Coordinates {
  String id;
  List<String> field;
  End start;
  End end;

  Coordinates({
    required this.id,
    required this.field,
    required this.start,
    required this.end,
  });

  Coordinates copyWith({
    String? id,
    List<String>? field,
    End? start,
    End? end,
  }) =>
      Coordinates(
        id: id ?? this.id,
        field: field ?? this.field,
        start: start ?? this.start,
        end: end ?? this.end,
      );

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
        id: json["id"],
        field: List<String>.from(json["field"].map((x) => x)),
        start: End.fromJson(json["start"]),
        end: End.fromJson(json["end"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "field": List<dynamic>.from(field.map((x) => x)),
        "start": start.toJson(),
        "end": end.toJson(),
      };
}

class End {
  int x;
  int y;

  End({
    required this.x,
    required this.y,
  });

  End copyWith({
    int? x,
    int? y,
  }) =>
      End(
        x: x ?? this.x,
        y: y ?? this.y,
      );

  factory End.fromJson(Map<String, dynamic> json) => End(
        x: json["x"],
        y: json["y"],
      );

  Map<String, dynamic> toJson() => {
        "x": x,
        "y": y,
      };
}
