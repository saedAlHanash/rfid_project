import '../response/division_response.dart';

class CreateDivisionRequest {
  CreateDivisionRequest({
    required this.id,
  });

  final String id;

  factory CreateDivisionRequest.fromJson(Map<String, dynamic> json) {
    return CreateDivisionRequest(
      id: json["id"] ?? "",
    );
  }

  factory CreateDivisionRequest.fromDivision(Division division) {
    return CreateDivisionRequest(
      id: division.id.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
