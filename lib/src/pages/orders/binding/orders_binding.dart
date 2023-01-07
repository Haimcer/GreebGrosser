import 'package:get/get.dart';
import 'package:greengrosser/src/pages/orders/controller/all_orders_cotroller.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AllOrdersController());
  }
}
