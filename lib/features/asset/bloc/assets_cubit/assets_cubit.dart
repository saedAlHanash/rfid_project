import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart';
import 'package:image_multi_type/round_image_widget.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:rfid_project/core/api_manager/api_service.dart';
import 'package:rfid_project/core/api_manager/api_url.dart';
import 'package:rfid_project/core/extensions/extensions.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';
import 'package:rfid_project/core/util/pair_class.dart';
import 'package:rfid_project/features/asset/data/request/create_asset_request.dart';
import 'package:rfid_project/features/asset/data/response/asset_response.dart';
import 'package:rfid_project/features/entity/data/response/entity_response.dart';
import 'package:rfid_project/features/product/data/response/product_response.dart';

import '../../../../core/error/error_manager.dart';
import '../../../../core/widgets/spinner_widget.dart';

part 'assets_state.dart';

class AssetsCubit extends MCubit<AssetsInitial> {
  AssetsCubit() : super(AssetsInitial.initial());

  @override
  String get nameCache => 'assets';

  @override
  String get filter => state.filter;

  //region getData

  void getDataFromCache() => getFromCache(fromJson: Asset.fromJson, state: state);

  Future<void> getData({bool newData = false}) async {
    await getDataAbstract(
      fromJson: Asset.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<List<Asset>?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.asset,
      body: state.filterRequest?.toJson() ?? {},
    );

    if (response.statusCode.success) {
      return Pair(Assets.fromJson(response.jsonBodyPure).data, null);
    } else {
      return response.getPairError;
    }
  }

  //endregion

  //region CRUD
  Future<void> create() async {
    emit(state.copyWith(statuses: CubitStatuses.loading, cubitCrud: CubitCrud.create));

    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.createAsset,
      body: state.cRequest.toJson(),
    );

    await _updateState(response);
  }

  Future<void> update(int id) async {
    emit(state.copyWith(
        statuses: CubitStatuses.loading, cubitCrud: CubitCrud.update, id: id));

    final response = await APIService().callApi(
      type: ApiType.put,
      url: PutUrl.updateAsset,
      body: state.cRequest.toJsonUpdate(),
      path: state.mId.toString(),
    );
    await _updateState(response);
  }

  Future<void> delete({required int id}) async {
    emit(state.copyWith(
        statuses: CubitStatuses.loading, cubitCrud: CubitCrud.delete, id: id));

    final response = await APIService().callApi(
      type: ApiType.put,
      url: DeleteUrl.deleteAsset,
      query: {'id': state.id},
      path: state.id.toString(),
    );

    await _updateState(response, isDelete: true);
  }

  Future<void> deleteNow({required int id}) async {
    final index = state.result.indexWhere((element) => element.id == id);
    final item = state.result.removeAt(index);

    emit(state.copyWith(cubitCrud: CubitCrud.delete, result: state.result, id: id));

    final response = await APIService().callApi(
      type: ApiType.delete,
      url: DeleteUrl.deleteAsset,
      query: {'id': state.id},
    );

    if (response.statusCode.success) {
      await deleteAssetFromCache(item.id.toString());
    } else {
      showErrorFromApi(state);
      state.result.insert(index, item);
      emit(state.copyWith(statuses: CubitStatuses.error, result: state.result));
    }
  }

  Future<void> _updateState(Response response, {bool isDelete = false}) async {
    if (response.statusCode.success) {
      final item = Asset.fromJson(response.jsonBody);
      isDelete
          ? await deleteAssetFromCache(state.id.toString())
          : await addOrUpdateAssetToCache(item);
      emit(state.copyWith(statuses: CubitStatuses.done));
    } else {
      showErrorFromApi(state);
      emit(state.copyWith(statuses: CubitStatuses.error));
    }
  }

  void setProduct(Product product) {
    final request = CreateAssetRequest.fromJson({});
    request.asset = product.asset;
    request.room = product.room;
    request.division = product.room.division;
    request.department = product.room.division.department;
    request.entity = product.room.division.department.entity;

    emit(state.copyWith(cRequest: request, product: product));
  }

  //endregion

  //region setData

  //endregion
  Future<void> addOrUpdateAssetToCache(Asset item) async {
    final listJson = await addOrUpdateDate([item]);
    if (listJson == null) return;
    final list = listJson.map((e) => Asset.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }

  Future<void> deleteAssetFromCache(String id) async {
    final listJson = await deleteDate([id]);
    if (listJson == null) return;
    final list = listJson.map((e) => Asset.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }
}
