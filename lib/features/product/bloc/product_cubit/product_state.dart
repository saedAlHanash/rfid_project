part of 'product_cubit.dart';

class ProductInitial extends AbstractState<Product> {
  const ProductInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
  });

  factory ProductInitial.initial() {
    return ProductInitial(
      result: Product.fromJson({}),
      request: '',
    );
  }

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        if (request != null) request,
        if (filterRequest != null) filterRequest!,
      ];
      
  ProductInitial copyWith({
    CubitStatuses? statuses,
    Product? result,
    String? error,
    String? request,
  }) {
    return ProductInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}

   