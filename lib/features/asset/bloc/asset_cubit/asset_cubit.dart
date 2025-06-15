import 'package:rfid_project/core/api_manager/api_service.dart';
import 'package:rfid_project/core/api_manager/api_url.dart';
import 'package:rfid_project/core/extensions/extensions.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';
import 'package:rfid_project/core/util/pair_class.dart';
import 'package:rfid_project/features/asset/data/response/asset_response.dart';
import 'package:m_cubit/abstraction.dart';

part 'asset_state.dart';

class AssetCubit extends MCubit<AssetInitial> {
  AssetCubit() : super(AssetInitial.initial());

  @override
  String get nameCache => 'asset';

  @override
  String get filter => state.filter;

  Future<void> getData({bool newData = false, String? assetId}) async {
    emit(state.copyWith(request: assetId));

    await getDataAbstract(
      fromJson: Asset.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<Asset?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.asset,
      query: {'Id': state.request},
    );

    if (response.statusCode.success) {
      return Pair(Asset.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }

  void setAsset(dynamic asset) {
    if (asset is! Asset) return;

    emit(state.copyWith(result: asset));
  }
}
