part of 'assets_cubit.dart';

class AssetsInitial extends AbstractState<List<Asset>> {
  const AssetsInitial({
    required super.result,
    required this.product,
    super.error,
    super.request,
    super.filterRequest,
    super.cubitCrud,
    super.createUpdateRequest,
    super.statuses,
    required super.id,
  });

  final Product product;

  factory AssetsInitial.initial() {
    return AssetsInitial(
      result: [],
      id: 0,
      product: Product.fromJson({}),
      createUpdateRequest: CreateAssetRequest.fromJson({}),
    );
  }

  CreateAssetRequest get cRequest {
    return createUpdateRequest as CreateAssetRequest;
  }

  int get mId => id;

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        cubitCrud,
        product,
        if (id != null) id,
        if (request != null) request,
        if (filterRequest != null) filterRequest!,
        if (createUpdateRequest != null) createUpdateRequest!,
      ];

  List<SpinnerItem> getSpinnerItems({int? selectedId}) {
    return List<SpinnerItem>.from(
      result.map(
        (e) => SpinnerItem(
          id: e.id,
          isSelected: e.id == (selectedId ?? product.asset.id),
          name: e.name,
          icon: RoundImageWidget(url: e.image, width: 30.0.r, height: 30.0.r),
          item: e,
        ),
      ),
    );
  }

  AssetsInitial copyWith({
    CubitStatuses? statuses,
    CubitCrud? cubitCrud,
    List<Asset>? result,
    String? error,
    FilterRequest? filterRequest,
    dynamic request,
    Product? product,
    CreateAssetRequest? cRequest,
    int? id,
  }) {
    return AssetsInitial(
      statuses: statuses ?? this.statuses,
      cubitCrud: cubitCrud ?? this.cubitCrud,
      result: result ?? this.result,
      error: error ?? this.error,
      filterRequest: filterRequest ?? this.filterRequest,
      request: request ?? this.request,
      createUpdateRequest: cRequest ?? this.cRequest,
      id: id ?? this.id,
      product: product ?? this.product,
    );
  }
}
