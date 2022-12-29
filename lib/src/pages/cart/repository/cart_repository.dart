import 'package:greengrosser/src/constants/endpoints.dart';
import 'package:greengrosser/src/pages/cart/cart_result/cart_result.dart';
import 'package:greengrosser/src/services/http_manager.dart';

import '../../../models/cart_item_model.dart';

class CartRepository {
  final _httpManager = HttpManeger();

  Future<CartResult<List<CartItemModel>>> getCartItems({
    required String token,
    required String userId,
  }) async {
    final result = await _httpManager.restRequest(
      url: Endpoints.getCartItems,
      method: HttpMethods.post,
      headers: {
        'X-Parse-Session-Token': token,
      },
      body: {'user': userId},
    );

    if (result['result'] != null) {
      List<CartItemModel> data =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromJson)
              .toList();

      return CartResult<List<CartItemModel>>.success(data);
    } else {
      return CartResult.error(
          'Ocorreu um erro ao recuperar os itens do carrinho');
    }
  }
}
