part of 'divisions_cubit.dart';

class DivisionsInitial extends AbstractState<List<Division>> {
  const DivisionsInitial({
    required super.result,
    this.selectedId,
    super.error,
    super.request,
    super.filterRequest,
    super.cubitCrud,
    super.createUpdateRequest,
    super.statuses,
    super.id,
  });

  final int? selectedId;

  factory DivisionsInitial.initial() {
    return DivisionsInitial(
      result: [],
      createUpdateRequest: CreateDivisionRequest.fromJson({}),
    );
  }

  CreateDivisionRequest get cRequest => createUpdateRequest;

  String get mId => id;

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        cubitCrud,
        if (id != null) id,
        if (selectedId != null) selectedId!,
        if (request != null) request,
        if (filterRequest != null) filterRequest!,
        if (createUpdateRequest != null) createUpdateRequest!,
      ];

  List<SpinnerItem> getSpinnerItems({int? selectedId}) {
    return List<SpinnerItem>.from(
      result.map(
        (e) => SpinnerItem(
          id: e.id,
          isSelected: e.id == (this.selectedId ?? selectedId),
          name: e.name,
          item: e,
        ),
      ),
    );
  }

  DivisionsInitial copyWith({
    CubitStatuses? statuses,
    CubitCrud? cubitCrud,
    List<Division>? result,
    String? error,
    FilterRequest? filterRequest,
    dynamic request,
    dynamic cRequest,
    dynamic id,
    int? selectedId,
  }) {
    return DivisionsInitial(
      statuses: statuses ?? this.statuses,
      cubitCrud: cubitCrud ?? this.cubitCrud,
      result: result ?? this.result,
      error: error ?? this.error,
      filterRequest: filterRequest ?? this.filterRequest,
      request: request ?? this.request,
      createUpdateRequest: cRequest ?? this.cRequest,
      id: id ?? this.id,
      selectedId: selectedId ?? this.selectedId,
    );
  }
}
