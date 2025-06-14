part of 'update_profile_cubit.dart';

class UpdateProfileInitial extends AbstractState<UserModel> {
  UpdateProfileRequest get mRequest => request;

  // final  bool educationalGradeParam;
  const UpdateProfileInitial({
    required super.result,
    super.error,
    super.request,
    // required this.educationalGradeParam,
    super.statuses,
  }); //

  factory UpdateProfileInitial.initial() {
    return UpdateProfileInitial(
      result: UserModel.fromJson({}),
      error: '',
      // educationalGradeParam: false,
      request: UpdateProfileRequest.fromJson(AppProvider.getMe.toJson()),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  UpdateProfileInitial copyWith({
    CubitStatuses? statuses,
    UserModel? result,
    String? error,
    UpdateProfileRequest? request,
  }) {
    return UpdateProfileInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
