class Product {
  Product({
    required this.id,
  });

  final String id;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"] ?? "",
    );
  }

//</editor-fold>
}

class Products {
  final List<Product> items;

  const Products({
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'items': items,
    };
  }

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      items: json['items'] as List<Product>,
    );
  }
}

