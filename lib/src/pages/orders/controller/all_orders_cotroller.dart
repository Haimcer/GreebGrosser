import 'package:get/get.dart';
import 'package:greengrosser/src/models/order_model.dart';
import 'package:greengrosser/src/pages/auth/controller/auth_controller.dart';
import 'package:greengrosser/src/pages/orders/orders_result/orders_result.dart';
import 'package:greengrosser/src/pages/orders/repository/orders_repository.dart';
import 'package:greengrosser/src/services/utils_services.dart';

class AllOrdersController extends GetxController {
  final ordersRepository = OrdersRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();
  List<OrderModel> allOrders = [];

  @override
  void onInit() {
    super.onInit();
    getAllOrders();
  }

  Future<void> getAllOrders() async {
    OrdersResult<List<OrderModel>> result = await ordersRepository.getAllOrders(
        userId: authController.user.id!, token: authController.user.token!);

    result.when(
      success: (orders) {
        allOrders = orders;
        update();
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
