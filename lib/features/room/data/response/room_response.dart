import '../../../division/data/response/division_response.dart';

class Rooms {
  Rooms({
    required this.data,
  });

  final List<Room> data;

  factory Rooms.fromJson(Map<String, dynamic> json) {
    return Rooms(
      data: json["data"] == null ? [] : List<Room>.from(json["data"]!.map((x) => Room.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Room {
  Room({
    required this.id,
    required this.name,
    required this.division,
    required this.assetItemsCount,
  });

  final int id;
  final String name;
  final Division division;
  final num assetItemsCount;

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      division: Division.fromJson(json["division"] ?? {}),
      assetItemsCount: json["asset_items_count"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "division": division.toJson(),
        "asset_items_count": assetItemsCount,
      };
}
