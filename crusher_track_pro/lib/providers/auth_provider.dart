import 'package:flutter/material.dart';

import '../models/login_response.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;

  LoginUser? _user;

  bool get isLoading => _isLoading;

  LoginUser? get user => _user;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await AuthService.login(
        email: email,
        password: password,
      );

      _user = response.user;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await AuthService.logout();

    _user = null;

    notifyListeners();
  }
}