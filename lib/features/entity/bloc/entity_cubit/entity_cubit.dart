import 'package:m_cubit/abstraction.dart';
import 'package:rfid_project/core/api_manager/api_service.dart';
import 'package:rfid_project/core/api_manager/api_url.dart';
import 'package:rfid_project/core/extensions/extensions.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';
import 'package:rfid_project/core/util/pair_class.dart';
import 'package:rfid_project/features/entity/data/response/entity_response.dart';

part 'entity_state.dart';

class EntityCubit extends MCubit<EntityInitial> {
  EntityCubit() : super(EntityInitial.initial());

  @override
  String get nameCache => 'entity';

  @override
  String get filter => state.filter;

  Future<void> getData({bool newData = false, String? entityId}) async {
    emit(state.copyWith(request: entityId));

    await getDataAbstract(
      fromJson: Entity.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<Entity?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.entity,
      query: {'Id': state.request},
    );

    if (response.statusCode.success) {
      return Pair(Entity.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }

  void setEntity(dynamic entity) {
    if (entity is! Entity) return;

    emit(state.copyWith(result: entity));
  }
}
