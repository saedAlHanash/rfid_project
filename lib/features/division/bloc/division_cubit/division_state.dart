part of 'division_cubit.dart';

class DivisionInitial extends AbstractState<Division> {
  const DivisionInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
  });

  factory DivisionInitial.initial() {
    return DivisionInitial(
      result: Division.fromJson({}),
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

  DivisionInitial copyWith({
    CubitStatuses? statuses,
    Division? result,
    String? error,
    String? request,
  }) {
    return DivisionInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
