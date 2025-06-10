part of 'home_cubit.dart';

class HomeInitial extends AbstractState<bool> {
  const HomeInitial({
    required super.result,
    super.error,
    required super.request,
    required this.controller,
    required this.notify,
    super.statuses,
  });

  final PageController controller;
  final int notify;

  factory HomeInitial.initial() {
    return HomeInitial(
      result: true,
      controller: PageController(initialPage: 0),
      notify: 0,
      error: '',
      request: '',
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [
        statuses,
        result,
        controller,
        error,
        notify,
        if (request != null) request,
        if (filterRequest != null) filterRequest!
      ];

  HomeInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    int? notify,
    String? request,
    PageController? controller,
  }) {
    return HomeInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      notify: notify ?? this.notify,
      controller: controller ?? this.controller,
    );
  }
}
