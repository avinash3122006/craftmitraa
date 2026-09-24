import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/app_config.dart';

class ApiClient {
  ApiClient._();

  static final ApiClient _instance = ApiClient._();

  factory ApiClient() => _instance;

  Uri _buildUri(String path) {
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    return Uri.parse('${AppConfig.apiBaseUrl}$normalizedPath');
  }

  Map<String, String> _headers({String? token}) {
    final headers = <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  Future<Map<String, dynamic>> get(String path, {String? token}) async {
    final response = await http
        .get(_buildUri(path), headers: _headers(token: token))
        .timeout(const Duration(seconds: 20));
    return _decodeResponse(response);
  }

  Future<Map<String, dynamic>> post(
    String path,
    Map<String, dynamic> body, {
    String? token,
  }) async {
    final response = await http
        .post(
          _buildUri(path),
          headers: _headers(token: token),
          body: jsonEncode(body),
        )
        .timeout(const Duration(seconds: 20));
    return _decodeResponse(response);
  }

  Map<String, dynamic> _decodeResponse(http.Response response) {
    final decoded = response.body.trim();
    if (decoded.isEmpty) {
      return <String, dynamic>{};
    }

    try {
      final payload = jsonDecode(decoded);
      if (payload is Map<String, dynamic>) {
        return payload;
      }
      if (payload is Map) {
        return Map<String, dynamic>.from(payload);
      }
      return {'data': payload};
    } on FormatException {
      throw ApiException('Invalid JSON response from server.');
    }
  }
}

class ApiException implements Exception {
  ApiException(this.message);

  final String message;

  @override
  String toString() => message;
}
