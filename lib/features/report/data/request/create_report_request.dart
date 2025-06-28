class CreateReportRequest {
  CreateReportRequest({
    required this.roomId,
    required this.labels,
  });

   int roomId;
   List<String> labels;

  factory CreateReportRequest.fromJson(Map<String, dynamic> json){
    return CreateReportRequest(
      roomId: json["room_id"] ?? 0,
      labels: json["labels"] == null ? [] : List<String>.from(json["labels"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
    "room_id": roomId,
    "labels": labels.map((x) => x).toList(),
  };

}
