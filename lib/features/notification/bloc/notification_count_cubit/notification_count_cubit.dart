import 'package:rfid_project/core/util/shared_preferences.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_count_state.dart';

class NotificationCountCubit extends Cubit<NotificationCountInitial> {
  NotificationCountCubit() : super(NotificationCountInitial.initial());

  void changeCount() {
    emit(state.copyWith(result: AppSharedPreference.getNotificationCount()));
  }


}
