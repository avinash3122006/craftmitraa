import '../models/user_model.dart';
import 'api_client.dart';

class AuthSession {
  AuthSession({
    required this.accessToken,
    required this.user,
  });

  final String accessToken;
  final UserModel user;

  factory AuthSession.fromJson(Map<String, dynamic> json) {
    return AuthSession(
      accessToken: json['access_token'] as String? ?? '',
      user: UserModel.fromApiJson(
        (json['user'] as Map<String, dynamic>? ?? <String, dynamic>{}),
      ),
    );
  }
}

class AuthApi {
  final ApiClient _apiClient = ApiClient();

  Future<AuthSession> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required UserRole role,
  }) async {
    final response = await _apiClient.post(
      '/api/v1/auth/register',
      {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
        'role': role.name,
      },
    );

    if (response['detail'] != null) {
      throw ApiException(response['detail'].toString());
    }

    return AuthSession.fromJson(response);
  }

  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiClient.post(
      '/api/v1/auth/login',
      {
        'email': email,
        'password': password,
      },
    );

    if (response['detail'] != null) {
      throw ApiException(response['detail'].toString());
    }

    return AuthSession.fromJson(response);
  }

  Future<UserModel> getCurrentUser(String token) async {
    final response = await _apiClient.get('/api/v1/auth/me', token: token);
    if (response['detail'] != null) {
      throw ApiException(response['detail'].toString());
    }

    return UserModel.fromApiJson(response);
  }
}
