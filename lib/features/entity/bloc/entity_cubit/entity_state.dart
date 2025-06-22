part of 'entity_cubit.dart';

class EntityInitial extends AbstractState<Entity> {
  const EntityInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
  });

  factory EntityInitial.initial() {
    return EntityInitial(
      result: Entity.fromJson({}),
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
      
  EntityInitial copyWith({
    CubitStatuses? statuses,
    Entity? result,
    String? error,
    String? request,
  }) {
    return EntityInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}

   