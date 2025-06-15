import '../response/report_response.dart';

class CreateReportRequest {
  CreateReportRequest({
    required this.id,
  });

  final String id;

  factory CreateReportRequest.fromJson(Map<String, dynamic> json) {
    return CreateReportRequest(
      id: json["id"] ?? "",
    );
  }

  factory CreateReportRequest.fromReport(Report report) {
    return CreateReportRequest(
      id: report.id,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

