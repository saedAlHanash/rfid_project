class Report {
  Report({
    required this.id,
  });

  final String id;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
    };
  }

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json["id"] ?? "",
    );
  }

//</editor-fold>
}

class Reports {
  final List<Report> items;

  const Reports({
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'items': items,
    };
  }

  factory Reports.fromJson(Map<String, dynamic> json) {
    return Reports(
      items: json['items'] as List<Report>,
    );
  }
}

