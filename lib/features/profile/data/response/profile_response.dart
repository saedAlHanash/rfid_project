class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.isActive,
    required this.expiryDate,
    required this.createdAt,
    required this.entity,
    required this.departmen,
    required this.division,
  });

  final int id;
  final String name;
  final String phone;
  final bool isActive;
  final DateTime? expiryDate;
  final String createdAt;
  final Entity entity;
  final dynamic departmen;
  final dynamic division;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      phone: json["phone"] ?? "",
      isActive: json["is_active"] ?? false,
      expiryDate: DateTime.tryParse(json["expiry_date"] ?? ""),
      createdAt: json["created_at"] ?? "",
      entity: Entity.fromJson(json["entity"] ?? {}),
      departmen: json["departmen"],
      division: json["division"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "is_active": isActive,
    "expiry_date": expiryDate?.toIso8601String(),
    "created_at": createdAt,
    "entity": entity?.toJson(),
    "departmen": departmen,
    "division": division,
  };
}

class Entity {
  Entity({required this.id, required this.name});

  final int id;
  final String name;

  factory Entity.fromJson(Map<String, dynamic> json) {
    return Entity(id: json["id"] ?? 0, name: json["name"] ?? "");
  }

  Map<String, dynamic> toJson() => {"id": id, "name": name};
}
