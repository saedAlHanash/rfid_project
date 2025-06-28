import '../../../../core/strings/enum_manager.dart';
import '../../../room/data/response/room_response.dart';

class Reports {
  Reports({
    required this.data,
  });

  final List<Report> data;

  factory Reports.fromJson(Map<String, dynamic> json) {
    return Reports(
      data: json["data"] == null
          ? []
          : List<Report>.from(json["data"]!.map((x) => Report.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Report {
  Report({
    required this.id,
    required this.room,
    required this.stats,
    required this.createdAt,
    required this.itemsDetails,
  });

  final int id;
  final Room room;
  final Stats stats;
  final String createdAt;
  final List<ItemsDetail> itemsDetails;

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json["id"] ?? 0,
      room: Room.fromJson(json["room"] ?? {}),
      stats: Stats.fromJson(json["stats"] ?? json["result"]?["stats"] ?? {}),
      createdAt: json["created_at"] ?? "",
      itemsDetails: (json["items_details"] ?? json["result"]?["items_details"]) == null
          ? []
          : List<ItemsDetail>.from((json["items_details"] ?? json["result"]?["items_details"])!.map((x) => ItemsDetail.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "room": room.toJson(),
        "stats": stats.toJson(),
        "created_at": createdAt,
        "items_details": itemsDetails.map((x) => x.toJson()).toList(),
      };
}

class Stats {
  Stats({
    required this.newCount,
    required this.foundCount,
    required this.labelsCount,
    required this.damagedCount,
    required this.unknownCount,
    required this.otherRoomCount,
  });

  final num newCount;
  final num foundCount;
  final num labelsCount;
  final num damagedCount;
  final num unknownCount;
  final num otherRoomCount;

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      newCount: json["new_count"] ?? 0,
      foundCount: json["found_count"] ?? 0,
      labelsCount: json["labels_count"] ?? 0,
      damagedCount: json["damaged_count"] ?? 0,
      unknownCount: json["unknown_count"] ?? 0,
      otherRoomCount: json["other_room_count"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        "new_count": newCount,
        "found_count": foundCount,
        "labels_count": labelsCount,
        "damaged_count": damagedCount,
        "unknown_count": unknownCount,
        "other_room_count": otherRoomCount,
      };
}

class ItemsDetail {
  ItemsDetail({
    required this.label,
    required this.status,
    required this.assetName,
    required this.inRequestedRoom,
  });

  final String label;
  final AssetStatus status;
  final String assetName;
  final bool inRequestedRoom;

  factory ItemsDetail.fromJson(Map<String, dynamic> json) {
    return ItemsDetail(
      label: json["label"] ?? "",
      status: AssetStatus.fromName(json["status"] ?? ""),
      assetName: json["asset_name"] ?? "",
      inRequestedRoom: json["in_requested_room"] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        "label": label,
        "status": status.nameApi,
        "asset_name": assetName,
        "in_requested_room": inRequestedRoom,
      };
}
