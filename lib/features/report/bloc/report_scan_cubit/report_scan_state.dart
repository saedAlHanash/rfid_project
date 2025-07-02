part of 'report_scan_cubit.dart';

class ReportScanInitial extends AbstractState<List<String>> {
  const ReportScanInitial({
    required super.result,
    super.error,
    super.request,
    super.filterRequest,
    super.cubitCrud,
    super.createUpdateRequest,
    super.statuses,
    super.id,
    required this.isRead,
    required this.match,
    required this.missing,
    required this.unsigned,
    required this.unknown,
    required this.labelNames,
    required this.scannedInfo,
  });

  final List<String> match;
  final List<String> missing;
  final List<String> unsigned;
  final List<String> unknown;
  final List<List<dynamic>> scannedInfo;
  final Map<String, List<String>> labelNames;
  final bool isRead;

  List<String> get allScanned => [...match, ...unsigned, ...unknown];

  factory ReportScanInitial.initial() {
    return const ReportScanInitial(
      result: <String>[],
      match: <String>[],
      missing: <String>[],
      scannedInfo: [[]],
      unsigned: <String>[],
      unknown: <String>[],
      labelNames: {},
      isRead: false,
    );
  }

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        cubitCrud,
        isRead,
        match,
        missing,
        unsigned,
        unknown,
        scannedInfo,
        labelNames,
        if (id != null) id,
        if (request != null) request,
        if (filterRequest != null) filterRequest!,
        if (createUpdateRequest != null) createUpdateRequest!,
      ];

  ReportScanInitial copyWith({
    CubitStatuses? statuses,
    CubitCrud? cubitCrud,
    List<String>? result,
    List<String>? match,
    List<String>? missing,
    List<String>? unsigned,
    List<String>? unknown,
    List<List<dynamic>>? scannedInfo,
    Map<String, List<String>>? labelNames,
    bool? isRead,
    String? error,
    FilterRequest? filterRequest,
    dynamic request,
    dynamic cRequest,
    dynamic id,
  }) {
    return ReportScanInitial(
      statuses: statuses ?? this.statuses,
      cubitCrud: cubitCrud ?? this.cubitCrud,
      result: result ?? this.result,
      error: error ?? this.error,
      filterRequest: filterRequest ?? this.filterRequest,
      request: request ?? this.request,
      isRead: isRead ?? this.isRead,
      match: match ?? this.match,
      missing: missing ?? this.missing,
      unsigned: unsigned ?? this.unsigned,
      unknown: unknown ?? this.unknown,
      labelNames: labelNames ?? this.labelNames,
      id: id ?? this.id,
      scannedInfo: scannedInfo ?? this.scannedInfo,
    );
  }
}
