part of 'scan_cubit.dart';

class ScanInitial extends AbstractState<List<String>> {
  const ScanInitial({
    required super.result,
    super.error,
    super.request,
    super.filterRequest,
    super.cubitCrud,
    super.createUpdateRequest,
    super.statuses,
    super.id,
    required this.isRead,
    required this.power,
  });

  final bool isRead;
  final int power;

  factory ScanInitial.initial() {
    return const ScanInitial(
      result: [],
      isRead: false,
      power: 0,
    );
  }

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        cubitCrud,
        isRead,
        power,
        if (id != null) id,
        if (request != null) request,
        if (filterRequest != null) filterRequest!,
        if (createUpdateRequest != null) createUpdateRequest!,
      ];

  ScanInitial copyWith({
    CubitStatuses? statuses,
    CubitCrud? cubitCrud,
    List<String>? result,
    bool? isRead,
    int? power,
    String? error,
    FilterRequest? filterRequest,
    dynamic request,
    dynamic cRequest,
    dynamic id,
  }) {
    return ScanInitial(
      statuses: statuses ?? this.statuses,
      cubitCrud: cubitCrud ?? this.cubitCrud,
      result: result ?? this.result,
      error: error ?? this.error,
      filterRequest: filterRequest ?? this.filterRequest,
      request: request ?? this.request,
      isRead: isRead ?? this.isRead,
      power: power ?? this.power,
      id: id ?? this.id,
    );
  }
}
