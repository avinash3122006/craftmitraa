import '../models/artisan_model.dart';
import '../models/product_model.dart';
import 'api_client.dart';

class ProductApi {
  final ApiClient _apiClient = ApiClient();

  List<dynamic> _extractList(Map<String, dynamic> response) {
    if (response['data'] is List) {
      return response['data'] as List<dynamic>;
    }
    if (response['items'] is List) {
      return response['items'] as List<dynamic>;
    }
    if (response.containsKey('data') && response['data'] is! List) {
      return const <dynamic>[];
    }
    return response.entries.isEmpty ? const <dynamic>[] : [response];
  }

  Future<List<ArtisanModel>> getArtisans({String? token}) async {
    final response = await _apiClient.get('/api/v1/artisans', token: token);
    final items = _extractList(response);

    return items
        .whereType<Map>()
        .map((item) => ArtisanModel.fromApiJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  Future<List<ProductModel>> getProducts({String? token}) async {
    final artisans = await getArtisans(token: token);
    final artisanLookup = {for (final artisan in artisans) artisan.id: artisan};

    final response = await _apiClient.get('/api/v1/products', token: token);
    final items = _extractList(response);

    return items.whereType<Map>().map((item) {
      final productJson = Map<String, dynamic>.from(item);
      final artisanId = productJson['artisan_id']?.toString() ?? '';
      return ProductModel.fromApiJson(
        productJson,
        artisan: artisanLookup[artisanId],
      );
    }).toList();
  }
}
