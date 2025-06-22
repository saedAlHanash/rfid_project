part of 'entities_cubit.dart';

class EntitiesInitial extends AbstractState<List<Entity>> {
  const EntitiesInitial({
    required super.result,
    super.error,
    super.request,
    super.filterRequest,
    super.cubitCrud,
    super.createUpdateRequest,
    super.statuses,
    super.id,
  });

  factory EntitiesInitial.initial() {
    return EntitiesInitial(
      result: [],
      createUpdateRequest: CreateEntityRequest.fromJson({}),
    );
  }

  CreateEntityRequest get cRequest => createUpdateRequest;

  String get mId => id;

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        cubitCrud,
        if (id != null) id,
        if (request != null) request,
        if (filterRequest != null) filterRequest!,
        if (createUpdateRequest != null) createUpdateRequest!,
      ];

  List<SpinnerItem> getSpinnerItems({int? selectedId}) {
    loggerObject.w(result.length);
    return List<SpinnerItem>.from(
      result.map(
        (e) => SpinnerItem(
          id: e.id,
          isSelected: e.id == selectedId,
          name: e.name,
          item: e,
        ),
      ),
    );
  }

  EntitiesInitial copyWith({
    CubitStatuses? statuses,
    CubitCrud? cubitCrud,
    List<Entity>? result,
    String? error,
    FilterRequest? filterRequest,
    dynamic request,
    dynamic cRequest,
    dynamic id,
  }) {
    return EntitiesInitial(
      statuses: statuses ?? this.statuses,
      cubitCrud: cubitCrud ?? this.cubitCrud,
      result: result ?? this.result,
      error: error ?? this.error,
      filterRequest: filterRequest ?? this.filterRequest,
      request: request ?? this.request,
      createUpdateRequest: cRequest ?? this.cRequest,
      id: id ?? this.id,
    );
  }
}
