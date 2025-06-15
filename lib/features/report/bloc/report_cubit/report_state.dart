part of 'report_cubit.dart';

class ReportInitial extends AbstractState<Report> {
  const ReportInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
  });

  factory ReportInitial.initial() {
    return ReportInitial(
      result: Report.fromJson({}),
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
      
  ReportInitial copyWith({
    CubitStatuses? statuses,
    Report? result,
    String? error,
    String? request,
  }) {
    return ReportInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}

   