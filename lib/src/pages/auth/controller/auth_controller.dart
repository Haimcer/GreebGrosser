import 'package:get/get.dart';
import 'package:greengrosser/src/constants/storage_keys.dart';
import 'package:greengrosser/src/models/user_model.dart';
import 'package:greengrosser/src/pages/auth/result/auth_result.dart';
import 'package:greengrosser/src/services/utils_services.dart';

import '../../../pages_routes/app_pages.dart';
import '../repository/auth_repository.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  final utilsServices = UtilsServices();
  final authRepository = AuthRepository();
  UserModel user = UserModel();

  @override
  void onInit() {
    super.onInit();

    validateToken();
  }

  Future<void> validateToken() async {
    //* Recuperar token local

    String? token = await utilsServices.getLocalData(key: StorageKeys.token);

    if (token == null) {
      Get.offAllNamed(PagesRoutes.singInRoute);
      return;
    }
    AuthResult result = await authRepository.validateToken(token);

    result.when(
      success: (user) {
        this.user = user;
        saveTokenProceedToBase();
      },
      error: (message) {
        signOut();
      },
    );
  }

  Future<void> signOut() async {
    //*Zerar o user
    user = UserModel();
    //*Remover token local
    await utilsServices.removeLocalData(key: StorageKeys.token);
    //*Ir para o login
    Get.offAllNamed(PagesRoutes.singInRoute);
  }

  void saveTokenProceedToBase() {
    //*Salvar o token

    utilsServices.saveLocalData(key: StorageKeys.token, data: user.token!);

    //* Ir para a base
    Get.offAllNamed(PagesRoutes.baseRoute);
  }

  Future<void> signIn({required String email, required String password}) async {
    isLoading.value = true;

    AuthResult result =
        await authRepository.singnIn(email: email, password: password);

    isLoading.value = false;

    result.when(success: (user) {
      this.user = user;

      saveTokenProceedToBase();
    }, error: (message) {
      utilsServices.showToast(
        message: message,
        isError: true,
      );
    });
  }
}
