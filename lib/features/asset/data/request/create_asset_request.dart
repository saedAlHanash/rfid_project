import '../../../department/data/response/department_response.dart';
import '../../../division/data/response/division_response.dart';
import '../../../entity/data/response/entity_response.dart';
import '../../../room/data/response/room_response.dart';
import '../response/asset_response.dart';

class CreateAssetRequest {
  CreateAssetRequest({
    required this.id,
    required this.entity,
    required this.department,
    required this.division,
    required this.asset,
    required this.room,
    required this.labels,
  });

  int id;
  Asset asset;
  Entity entity;
  Department department;
  Division division;
  Room room;
  final List<String> labels;

  factory CreateAssetRequest.fromJson(Map<String, dynamic> json) {
    return CreateAssetRequest(
      id: json["id"] ?? 0,
      entity: json["entity"] ?? Entity.fromJson({}),
      department: json["department"] ?? Department.fromJson({}),
      division: json["division"] ?? Division.fromJson({}),
      asset: json["asset"] ?? Asset.fromJson({}),
      room: json["room"] ?? Room.fromJson({}),
      labels: json["labels"] == null
          ? [
              'EB23Z3KTC5X1BAEGUEALTZOY',
            ]
          : List<String>.from(json["labels"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "entity_id": entity.id,
        "department_id": department.id,
        "division_id": division.id,
        "asset_id": asset.id,
        "room_id": room.id,
        "labels": labels.map((x) => x).toList(),
      };
  Map<String, dynamic> toJsonUpdate() => {
        "id": id,
        "entity_id": entity.id,
        "department_id": department.id,
        "division_id": division.id,
        "asset_id": asset.id,
        "room_id": room.id,
        "label": labels.first,
      };
}
