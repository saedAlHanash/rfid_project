import '../../../department/data/response/department_response.dart';
import '../../../division/data/response/division_response.dart';
import '../../../entity/data/response/entity_response.dart';

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
  final Department departmen;
  final Division division;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      phone: json["phone"] ?? "",
      isActive: json["is_active"] ?? false,
      expiryDate: DateTime.tryParse(json["expiry_date"] ?? ""),
      createdAt: json["created_at"] ?? "",
      entity: Entity.fromJson(json["entity"] ?? {}),
      departmen: Department.fromJson(json["departmen"] ?? {}),
      division: Division.fromJson(json["division"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "is_active": isActive,
        "expiry_date": expiryDate?.toIso8601String(),
        "created_at": createdAt,
        "entity": entity.toJson(),
        "departmen": departmen.toJson(),
        "division": division.toJson(),
      };
}
