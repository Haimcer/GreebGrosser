import 'package:get/get.dart';
import 'package:greengrosser/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrosser/src/pages/cart/repository/cart_repository.dart';
import 'package:greengrosser/src/services/utils_services.dart';

import '../../../models/cart_item_model.dart';
import '../cart_result/cart_result.dart';

class CartController extends GetxController {
  final cartRepository = CartRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();
  List<CartItemModel> cartItems = [];

  @override
  void onInit() {
    super.onInit();

    getCartItems();
  }

  Future<void> getCartItems() async {
    final CartResult<List<CartItemModel>> result =
        await cartRepository.getCartItems(
      token: authController.user.token!,
      userId: authController.user.id!,
    );

    result.when(
      success: (data) {
        cartItems = data;
        update();

        print(data);
      },
      error: (message) {
        utilsServices.showToast(
          message: message,
          isError: true,
        );
      },
    );
  }
}
