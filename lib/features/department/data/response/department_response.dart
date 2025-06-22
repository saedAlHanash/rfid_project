import '../../../entity/data/response/entity_response.dart';

class Departments {
  Departments({
    required this.data,
  });

  final List<Department> data;

  factory Departments.fromJson(Map<String, dynamic> json) {
    return Departments(
      data:
          json["data"] == null ? [] : List<Department>.from(json["data"]!.map((x) => Department.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x?.toJson()).toList(),
      };
}

class Department {
  Department({
    required this.id,
    required this.name,
    required this.entity,
    required this.createdAt,
  });

  final int id;
  final String name;
  final Entity entity;
  final String createdAt;

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      entity: Entity.fromJson(json["entity"] ?? {}),
      createdAt: json["created_at"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "entity": entity?.toJson(),
        "created_at": createdAt,
      };
}
