part of 'department_cubit.dart';

class DepartmentInitial extends AbstractState<Department> {
  const DepartmentInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
  });

  factory DepartmentInitial.initial() {
    return DepartmentInitial(
      result: Department.fromJson({}),
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
      
  DepartmentInitial copyWith({
    CubitStatuses? statuses,
    Department? result,
    String? error,
    String? request,
  }) {
    return DepartmentInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}

   