import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  TokenStorage._();

  static const FlutterSecureStorage _storage =
      FlutterSecureStorage();

  static const String tokenKey = "access_token";
  static const String usernameKey = "username";
  static const String emailKey = "email";
  static const String roleKey = "role";

  static Future<void> saveLogin({
    required String token,
    required String username,
    required String email,
    required String role,
  }) async {
    await _storage.write(
      key: tokenKey,
      value: token,
    );

    await _storage.write(
      key: usernameKey,
      value: username,
    );

    await _storage.write(
      key: emailKey,
      value: email,
    );

    await _storage.write(
      key: roleKey,
      value: role,
    );
  }

  static Future<String?> getToken() =>
      _storage.read(key: tokenKey);

  static Future<String?> getUsername() =>
      _storage.read(key: usernameKey);

  static Future<String?> getEmail() =>
      _storage.read(key: emailKey);

  static Future<String?> getRole() =>
      _storage.read(key: roleKey);

  static Future<void> logout() async {
    await _storage.deleteAll();
  }

  static Future<bool> isLoggedIn() async {
    final token = await getToken();

    return token != null && token.isNotEmpty;
  }
}