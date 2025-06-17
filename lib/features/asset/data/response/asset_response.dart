class Assets {
  Assets({
    required this.data,
  });

  final List<Asset> data;

  factory Assets.fromJson(Map<String, dynamic> json) {
    return Assets(
      data: json["data"] == null ? [] : List<Asset>.from(json["data"]!.map((x) => Asset.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Asset {
  Asset({
    required this.id,
    required this.name,
    required this.image,
    required this.note,
    required this.createdAt,
  });

  final int id;
  final String name;
  final String image;
  final String note;
  final String createdAt;

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      image: json["image"] ?? "",
      note: json["note"] ?? "",
      createdAt: json["created_at"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "note": note,
        "created_at": createdAt,
      };
}
