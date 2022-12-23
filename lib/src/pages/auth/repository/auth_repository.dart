import 'package:greengrosser/src/constants/endpoints.dart';
import 'package:greengrosser/src/models/user_model.dart';
import 'package:greengrosser/src/pages/auth/repository/auth_errors.dart'
    as authErrors;
import 'package:greengrosser/src/pages/auth/result/auth_result.dart';
import 'package:greengrosser/src/services/http_manager.dart';

class AuthRepository {
  final HttpManeger _httpManeger = HttpManeger();

  AuthResult handleUserOrError(Map<dynamic, dynamic> result) {
    if (result["result"] != null) {
      final user = UserModel.fromJson(result['result']);

      return AuthResult.success(user);
    } else {
      return AuthResult.error(authErrors.authErrorsString(result['error']));
    }
  }

  Future<AuthResult> validateToken(String token) async {
    final result = await _httpManeger.restRequest(
        url: Endpoints.validateToken,
        method: HttpMethods.post,
        headers: {
          'X-Parse-Session-Token': token,
        });

    return handleUserOrError(result);
  }

  Future<AuthResult> singnIn(
      {required String email, required String password}) async {
    final result = await _httpManeger
        .restRequest(url: Endpoints.signin, method: HttpMethods.post, body: {
      'email': email,
      'password': password,
    });

    return handleUserOrError(result);
  }

  Future<AuthResult> signUp(UserModel user) async {
    final result = await _httpManeger.restRequest(
      url: Endpoints.signup,
      method: HttpMethods.post,
      body: user.toJson(),
    );
    return handleUserOrError(result);
  }

  Future<void> resetPassword(email) async {
    await _httpManeger.restRequest(
        url: Endpoints.resetPassword,
        method: HttpMethods.post,
        body: {'email': email});
  }
}
