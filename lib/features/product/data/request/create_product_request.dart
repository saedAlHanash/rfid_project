import '../response/product_response.dart';

class CreateProductRequest {
  CreateProductRequest({
    required this.id,
  });

  final String id;

  factory CreateProductRequest.fromJson(Map<String, dynamic> json) {
    return CreateProductRequest(
      id: json["id"] ?? "",
    );
  }

  factory CreateProductRequest.fromProduct(Product product) {
    return CreateProductRequest(
      id: product.id.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
