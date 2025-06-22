import '../response/entity_response.dart';

class CreateEntityRequest {
  CreateEntityRequest({
    required this.id,
  });

  final String id;

  factory CreateEntityRequest.fromJson(Map<String, dynamic> json) {
    return CreateEntityRequest(
      id: json["id"] ?? "",
    );
  }

  factory CreateEntityRequest.fromEntity(Entity entity) {
    return CreateEntityRequest(
      id: entity.id.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
