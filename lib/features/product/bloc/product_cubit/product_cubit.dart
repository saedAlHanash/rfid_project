import 'package:m_cubit/abstraction.dart';
import 'package:rfid_project/core/api_manager/api_service.dart';
import 'package:rfid_project/core/api_manager/api_url.dart';
import 'package:rfid_project/core/extensions/extensions.dart';
import 'package:rfid_project/core/strings/enum_manager.dart';
import 'package:rfid_project/core/util/pair_class.dart';
import 'package:rfid_project/features/product/data/response/product_response.dart';

part 'product_state.dart';

class ProductCubit extends MCubit<ProductInitial> {
  ProductCubit() : super(ProductInitial.initial());

  @override
  String get nameCache => 'product';

  @override
  String get filter => state.filter;

  @override
  int get timeInterval => 10;

  Future<void> getData({bool newData = false, int? productId, String? tag}) async {
    emit(state.copyWith(id: productId, request: tag));

    await getDataAbstract(
      fromJson: Product.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<Product?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.product,
      query: {
        if (state.id > 0) ...{
          'filters[0][name]': 'room_id',
          'filters[0][operation]': '=',
          'filters[0][value]': state.id,
        },
        'keyword': state.request,
      },
    );

    if (response.statusCode.success) {
      return Pair(Product.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }

  void setProduct(dynamic product) {
    if (product is! Product) return;

    emit(state.copyWith(result: product));
  }
}
