import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/user_model.dart';
import '../services/auth_api.dart';

class AuthProvider with ChangeNotifier {
  AuthProvider() {
    _init();
  }

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final AuthApi _authApi = AuthApi();

  bool _isLoading = false;
  bool _isAuthenticated = false;
  UserRole _currentRole = UserRole.customer;
  UserModel? _currentUser;
  String? _accessToken;

  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  String? get accessToken => _accessToken;
  UserRole get currentRole => _currentRole;
  UserModel? get currentUser => _currentUser;
  UserModel get currentUserOrFallback => _currentUser ??
      UserModel(
        id: 'guest',
        name: 'Guest User',
        email: '',
        phone: '',
        role: UserRole.customer,
      );
  bool get isArtisanMode => _currentRole == UserRole.artisan;

  Future<void> _init() async {
    final token = await _secureStorage.read(key: 'craftmitra_access_token');
    if (token == null || token.isEmpty) {
      _isAuthenticated = false;
      notifyListeners();
      return;
    }

    try {
      _accessToken = token;
      final user = await _authApi.getCurrentUser(token);
      _currentUser = user;
      _currentRole = user.role;
      _isAuthenticated = true;
    } catch (_) {
      await logout();
    } finally {
      notifyListeners();
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required UserRole role,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final session = await _authApi.register(
        name: name,
        email: email,
        password: password,
        phone: phone,
        role: role,
      );

      await _persistSession(session);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final session = await _authApi.login(email: email, password: password);
      await _persistSession(session);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _persistSession(AuthSession session) async {
    _accessToken = session.accessToken;
    _currentUser = session.user;
    _currentRole = session.user.role;
    _isAuthenticated = true;

    await _secureStorage.write(key: 'craftmitra_access_token', value: session.accessToken);
    notifyListeners();
  }

  void toggleRole() {
    _currentRole = _currentRole == UserRole.customer ? UserRole.artisan : UserRole.customer;
    notifyListeners();
  }

  void setRole(UserRole role) {
    _currentRole = role;
    notifyListeners();
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    _currentUser = null;
    _accessToken = null;
    _currentRole = UserRole.customer;
    await _secureStorage.delete(key: 'craftmitra_access_token');
    notifyListeners();
  }
}
