class Asset {
  Asset({
    required this.id,
  });

  final String id;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
    };
  }

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json["id"] ?? "",
    );
  }

//</editor-fold>
}

class Assets {
  final List<Asset> items;

  const Assets({
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'items': items,
    };
  }

  factory Assets.fromJson(Map<String, dynamic> json) {
    return Assets(
      items: json['items'] as List<Asset>,
    );
  }
}

