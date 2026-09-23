import 'package:flutter/material.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = true;
  UserRole _currentRole = UserRole.customer;

  UserModel _currentUser = UserModel(
    id: 'u-101',
    name: 'Aarav Sharma',
    email: 'aarav.sharma@example.com',
    phone: '+91 98765 43210',
    role: UserRole.customer,
    location: 'Bengaluru, Karnataka',
  );

  final UserModel _artisanUser = UserModel(
    id: 'art-001',
    name: 'Pandit Ramkishan Prajapati',
    email: 'ramkishan.clay@craftmitra.in',
    phone: '+91 94140 12345',
    role: UserRole.artisan,
    avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=80',
    location: 'Molela Village, Rajsamand, Rajasthan',
    craftSpecialty: 'Terracotta & Terracotta Relief Plaques',
  );

  bool get isAuthenticated => _isAuthenticated;
  UserRole get currentRole => _currentRole;
  UserModel get currentUser => _currentRole == UserRole.artisan ? _artisanUser : _currentUser;
  bool get isArtisanMode => _currentRole == UserRole.artisan;

  void toggleRole() {
    _currentRole = _currentRole == UserRole.customer ? UserRole.artisan : UserRole.customer;
    notifyListeners();
  }

  void setRole(UserRole role) {
    _currentRole = role;
    notifyListeners();
  }

  void login(String phone, UserRole role) {
    _isAuthenticated = true;
    _currentRole = role;
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}
