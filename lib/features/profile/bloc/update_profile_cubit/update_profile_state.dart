part of 'update_profile_cubit.dart';

class UpdateProfileInitial extends AbstractState<ProfileResponse> {
  @override
  final UpdateProfileRequest request;

  // final  bool educationalGradeParam;
  const UpdateProfileInitial({
    required super.result,
    super.error,
    required this.request,
    // required this.educationalGradeParam,
    super.statuses,
  }); //

  factory UpdateProfileInitial.initial() {
    return UpdateProfileInitial(
      result: ProfileResponse.fromJson({}),
      error: '',
      // educationalGradeParam: false,
      request: UpdateProfileRequest.fromJson(AppProvider.getMe.toJson()),
      statuses: CubitStatuses.init,
    );
  }

  @override
  List<Object> get props => [statuses, result, error];

  UpdateProfileInitial copyWith(
      {CubitStatuses? statuses,
      ProfileResponse? result,
      String? error,
      UpdateProfileRequest? request}) {
    return UpdateProfileInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
    );
  }
}
