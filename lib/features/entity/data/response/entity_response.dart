class Entities {
  Entities({
    required this.data,
  });

  final List<Entity> data;

  factory Entities.fromJson(Map<String, dynamic> json) {
    return Entities(
      data: json["data"] == null ? [] : List<Entity>.from(json["data"]!.map((x) => Entity.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x?.toJson()).toList(),
      };
}

class Entity {
  Entity({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory Entity.fromJson(Map<String, dynamic> json) {
    return Entity(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
