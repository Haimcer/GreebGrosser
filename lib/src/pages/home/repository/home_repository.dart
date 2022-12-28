import 'package:greengrosser/src/constants/endpoints.dart';
import 'package:greengrosser/src/models/category_model.dart';
import 'package:greengrosser/src/pages/home/result/home_result.dart';
import 'package:greengrosser/src/services/http_manager.dart';

import '../../../models/item_model.dart';

class HomeRepository {
  final HttpManeger _httpManeger = HttpManeger();

  Future<HomeResult<CategoryModel>> getAllCategories() async {
    final result = await _httpManeger.restRequest(
        url: Endpoints.getAllCategories, method: HttpMethods.post);

    if (result['result'] != null) {
      //*Lista

      List<CategoryModel> data =
          (List<Map<String, dynamic>>.from(result['result']))
              .map(CategoryModel.fromJson)
              .toList();

      return HomeResult<CategoryModel>.success(data);
    } else {
      return HomeResult.error(
          'Ocorreu um erro inesperado ao recuperar as categorias');
    }
  }

  Future<HomeResult<ItemModel>> getAllProducts(
      Map<String, dynamic> body) async {
    final result = await _httpManeger.restRequest(
      url: Endpoints.getAllProducts,
      method: HttpMethods.post,
      body: body,
    );

    if (result['result'] != null) {
      List<ItemModel> data = List<Map<String, dynamic>>.from(result['result'])
          .map(ItemModel.fromJson)
          .toList();

      return HomeResult<ItemModel>.success(data);
    } else {
      return HomeResult.error(
          'Ocorreu um erro inesperado ao recuperar os itens');
    }
  }
}
