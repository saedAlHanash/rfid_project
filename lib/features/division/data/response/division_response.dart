import '../../../department/data/response/department_response.dart';

class Divisions {
  Divisions({
    required this.data,
  });

  final List<Division> data;

  factory Divisions.fromJson(Map<String, dynamic> json) {
    return Divisions(
      data: json["data"] == null ? [] : List<Division>.from(json["data"]!.map((x) => Division.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x?.toJson()).toList(),
      };
}

class Division {
  Division({
    required this.id,
    required this.name,
    required this.department,
    required this.assetsCount,
    required this.createdAt,
  });

  final int id;
  final String name;
  final Department department;
  final num assetsCount;
  final String createdAt;

  factory Division.fromJson(Map<String, dynamic> json) {
    return Division(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      department:Department.fromJson(json["department"]??{}),
      assetsCount: json["assets_count"] ?? 0,
      createdAt: json["created_at"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "department": department?.toJson(),
        "assets_count": assetsCount,
        "created_at": createdAt,
      };
}
