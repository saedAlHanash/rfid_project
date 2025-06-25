import '../../../asset/data/response/asset_response.dart';
import '../../../room/data/response/room_response.dart';
import '../../../room/data/response/room_response.dart';

class Products {
  Products({
    required this.data,
  });

  final List<Product> data;

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      data: json["data"] == null ? [] : List<Product>.from(json["data"]!.map((x) => Product.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.map((x) => x.toJson()).toList(),
      };
}

class Product {
  Product({
    required this.id,
    required this.label,
    required this.status,
    required this.asset,
    required this.room,
  });

  final int id;
  String label;
  final String status;
  final Asset asset;
  final Room room;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"] ?? 0,
      label: json["label"] ?? "",
      status: json["status"] ?? "",
      asset: Asset.fromJson(json["asset"] ?? {}),
      room: Room.fromJson(json["room"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "status": status,
        "asset": asset.toJson(),
        "room": room.toJson(),
      };
}
