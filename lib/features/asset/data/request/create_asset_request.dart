import '../response/asset_response.dart';

class CreateAssetRequest {
  CreateAssetRequest({
    required this.id,
  });

  final String id;

  factory CreateAssetRequest.fromJson(Map<String, dynamic> json) {
    return CreateAssetRequest(
      id: json["id"] ?? "",
    );
  }

  factory CreateAssetRequest.fromAsset(Asset asset) {
    return CreateAssetRequest(
      id: asset.id,
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

