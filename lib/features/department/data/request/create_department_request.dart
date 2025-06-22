import '../response/department_response.dart';

class CreateDepartmentRequest {
  CreateDepartmentRequest({
    required this.id,
  });

  final String id;

  factory CreateDepartmentRequest.fromJson(Map<String, dynamic> json) {
    return CreateDepartmentRequest(
      id: json["id"] ?? "",
    );
  }

  factory CreateDepartmentRequest.fromDepartment(Department department) {
    return CreateDepartmentRequest(
      id: department.id.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
