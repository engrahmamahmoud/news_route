import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../core/constants/api_constants.dart';
import '../models/article_model.dart';

class NewsApiService {
  Future<List<ArticleModel>> getTopHeadlines({
    required String category,
    String language = 'en',
    String country = 'us',
  }) async {
    final uri = Uri.parse(ApiConstants.topHeadlines).replace(
      queryParameters: {
        'country': country,
        'category': category,
        'pageSize': '20',
        'apiKey': ApiConstants.apiKey,
      },
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load top headlines');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    if (data['status'] != 'ok') {
      throw Exception(data['message'] ?? 'Something went wrong');
    }

    final articles = (data['articles'] as List<dynamic>? ?? []);

    return articles
        .map(
          (e) => ArticleModel.fromJson(
            e as Map<String, dynamic>,
            categoryId: category,
          ),
        )
        .where((article) => article.titleEn.trim().isNotEmpty)
        .toList();
  }

  Future<List<ArticleModel>> searchNews({
    required String query,
    String language = 'en',
  }) async {
    final uri = Uri.parse(ApiConstants.everything).replace(
      queryParameters: {
        'q': query,
        'sortBy': 'publishedAt',
        'pageSize': '30',
        'apiKey': ApiConstants.apiKey,
      },
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to search news');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    if (data['status'] != 'ok') {
      throw Exception(data['message'] ?? 'Something went wrong');
    }

    final articles = (data['articles'] as List<dynamic>? ?? []);

    return articles
        .map(
          (e) => ArticleModel.fromJson(
            e as Map<String, dynamic>,
            categoryId: 'search',
          ),
        )
        .where((article) => article.titleEn.trim().isNotEmpty)
        .toList();
  }

  Future<List<String>> getSources({
    String category = 'general',
    String language = 'en',
    String country = 'us',
  }) async {
    final uri = Uri.parse(ApiConstants.sources).replace(
      queryParameters: {
        'category': category,
        'country': country,
        'language': language,
        'apiKey': ApiConstants.apiKey,
      },
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load sources');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    if (data['status'] != 'ok') {
      throw Exception(data['message'] ?? 'Something went wrong');
    }

    final sources = (data['sources'] as List<dynamic>? ?? []);

    return sources
        .map((e) => (e as Map<String, dynamic>)['name']?.toString() ?? '')
        .where((e) => e.isNotEmpty)
        .take(10)
        .toList();
  }
}
