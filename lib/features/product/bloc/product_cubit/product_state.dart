part of 'product_cubit.dart';

class ProductInitial extends AbstractState<Product> {
  const ProductInitial({
    required super.result,
    super.error,
    required super.request,
    required super.id,
    super.statuses,
  });

  factory ProductInitial.initial() {
    return ProductInitial(
      result: Product.fromJson({}),
      request: '',
      id: 0,
    );
  }

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        id,
        if (request != null) request,
        if (filterRequest != null) filterRequest!,
      ];

  ProductInitial copyWith({
    CubitStatuses? statuses,
    Product? result,
    String? error,
    String? request,
    int? id,
  }) {
    return ProductInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      id: id ?? this.id,
    );
  }
}
