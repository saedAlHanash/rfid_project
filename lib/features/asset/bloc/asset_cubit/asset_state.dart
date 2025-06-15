part of 'asset_cubit.dart';

class AssetInitial extends AbstractState<Asset> {
  const AssetInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
  });

  factory AssetInitial.initial() {
    return AssetInitial(
      result: Asset.fromJson({}),
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
      
  AssetInitial copyWith({
    CubitStatuses? statuses,
    Asset? result,
    String? error,
    String? request,
  }) {
    return AssetInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}

   