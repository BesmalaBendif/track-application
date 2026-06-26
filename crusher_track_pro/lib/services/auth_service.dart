import 'package:dio/dio.dart';

import '../api/api_client.dart';
import '../api/api_constants.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';
import '../storage/token_storage.dart';

class AuthService {
  AuthService._();

  static Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await ApiClient.dio.post(
        ApiConstants.login,
        data: LoginRequest(
          email: email,
          password: password,
        ).toJson(),
      );

      final loginResponse = LoginResponse.fromJson(
        response.data,
      );

      await TokenStorage.saveLogin(
        token: loginResponse.accessToken,
        username: loginResponse.user.username,
        email: loginResponse.user.email,
        role: loginResponse.user.role,
      );

      return loginResponse;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
          e.response?.data["detail"] ??
              "Login failed.",
        );
      }

      throw Exception(
        "Unable to connect to the server.",
      );
    } catch (e) {
      throw Exception(
        "Something went wrong.",
      );
    }
  }

  static Future<void> logout() async {
    await TokenStorage.logout();
  }

  static Future<bool> isLoggedIn() async {
    return await TokenStorage.isLoggedIn();
  }
}